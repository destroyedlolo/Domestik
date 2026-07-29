-- Simulate AutoConso from Production
-->> group=Electricité.Puissance
--
-->> listen=ProdPower
-->> need_topic=ProdPower
--
-->> need_topic=SimulAutoConsoPower
--
-->> require_topic=CombleTemperature
-->> require_topic=ExterieurTemperature

-- Where are we ?
local LATITUDE = 45.921278
local LONGITUDE = 6.017500


-- Fonction astronomique : Calcul de l'Azimut du Soleil (en degrés)
local function GetSolarAzimuth(lat, lon)
local dateTable = os.date("!*t") -- UTC
    local year = dateTable.year
    local month = dateTable.month
    local day = dateTable.day
    local hourUTC = dateTable.hour + (dateTable.min / 60) + (dateTable.sec / 3600)

    -- Jour de l'année (1 à 365/366)
    local N = dateTable.yday

    -- Déclinaison solaire (en radians)
    local dec = math.rad(23.45 * math.sin(math.rad(360 / 365 * (N - 81))))

    -- Équation du temps (en minutes)
    local b = math.rad(360 / 365 * (N - 81))
    local eot = 9.87 * math.sin(2 * b) - 7.53 * math.cos(b) - 1.5 * math.sin(b)

    -- Temps Solaire Vrai (en heures)
    local solarTime = hourUTC + (4 * lon + eot) / 60

    -- Angle horaire H (en radians)
    local H = math.rad(15 * (solarTime - 12))

    -- Conversion Latitude en radians
    local latRad = math.rad(lat)

    -- Hauteur du Soleil / Elévation (en radians)
    local sinAlt = math.sin(latRad) * math.sin(dec) + math.cos(latRad) * math.cos(dec) * math.cos(H)
    sinAlt = math.max(-1.0, math.min(1.0, sinAlt))
    local alt = math.asin(sinAlt)

    -- Azimut du Soleil (en radians puis degrés)
    local cosAz = (math.sin(dec) * math.cos(latRad) - math.cos(dec) * math.sin(latRad) * math.cos(H)) / math.cos(alt)
    local sinAz = -math.cos(dec) * math.sin(H) / math.cos(alt)

    local az = math.deg(math.atan(sinAz, cosAz))
    if az < 0 then az = az + 360 end

    return az
end

local function CalculateSimulAutoConso(pOA, tComble, lat, lon)
    if pOA <= 0 then
        return 0.0
    end

    -- A. Ratio thermique (combles)
    local ratioTemp = 0.087 + (0.0105 * tComble)

    -- B. Azimut du Soleil
    local azimuth = GetSolarAzimuth(lat, lon)

    -- C. Facteur d'ombrage lissé basé sur l'azimut du soleil (creux à 98.5°)
    -- 98.5° correspond à la direction exacte du masque physique sur le toit
    local kOmbre = 1.0 - 0.60 * math.exp(-0.5 * math.pow((azimuth - 98.5) / 6.8, 2))

    -- D. Puissance simulée finale
    local simulPower = pOA * ratioTemp * kOmbre

    return math.max(0.0, simulPower)
end

local PTheoretical = CalculateSimulAutoConso(ProdPower:getVal(), CombleTemperature:getVal(), LATITUDE, LONGITUDE)

-- print("Theorique :", PTheoretical)

SimulAutoConsoPower:Publish(PTheoretical)
