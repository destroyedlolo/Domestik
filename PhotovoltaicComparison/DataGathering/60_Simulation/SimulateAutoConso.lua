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


-- Fonction interne : calcul rapide de l'azimut solaire (en degrés depuis le Nord = 0°)
-- Azimut computation (North = 0°
local function obtenir_azimut_soleil(lat, lon)
    local now = os.date("!*t") -- Temps universel UTC
    
    -- Day of the year
    local day_of_year = now.yday
    local hour_utc = now.hour + (now.min / 60.0) + (now.sec / 3600.0)
    
    -- Declinaison solaire approximative (en radians)
    local gamma = (2 * math.pi / 365) * (day_of_year - 1 + (hour_utc - 12) / 24)
    local decl = 0.006918 - 0.399912 * math.cos(gamma) + 0.070257 * math.sin(gamma)
        - 0.006758 * math.cos(2 * gamma) + 0.000907 * math.sin(2 * gamma)
    
    -- Equation du temps (en minutes)
    local eqtime = 229.18 * (0.000075 + 0.001868 * math.cos(gamma) - 0.032077 * math.sin(gamma)
        - 0.014615 * math.cos(2 * gamma) - 0.040849 * math.sin(2 * gamma))
    
    -- Angle horaire (en degrees)
    local time_offset = eqtime + 4 * lon
    local tst = hour_utc * 60 + time_offset
    local ha_deg = (tst / 4) - 180
    local ha_rad = math.rad(ha_deg)
    
    local lat_rad = math.rad(lat)
    
    -- Elevation solaire (en radians)
    local sin_el = math.sin(lat_rad) * math.sin(decl) + math.cos(lat_rad) * math.cos(decl) * math.cos(ha_rad)
    local el_rad = math.asin(sin_el)
    
    -- Azimut solaire (en radians puis degres)
    local cos_az = (math.sin(decl) - math.sin(lat_rad) * math.sin(el_rad)) / (math.cos(lat_rad) * math.cos(el_rad))
    cos_az = math.max(-1.0, math.min(1.0, cos_az)) -- Clamp
    
    local az_deg = math.deg(math.acos(cos_az))
    if math.sin(ha_rad) > 0 then
        az_deg = 360 - az_deg
    end
    
    return az_deg
end

-- Fonction principale de calcul de l'AutoConso virtuelle
-- Inputs:
--   ProdPower:getVal() : Puissance "Production" (W)
--   CombleTemperature     : Temperature "Comble" (°C)
--   PAutoConso  : Puissance reelle "AutoConso" si disponible (sinon passer 0) (W)
--   ExterieurTemperature  : Temperature "Dehors" (°C)

-- 1. Obtenir l'azimut solaire actuel basé sur vos coordonnées GPS
local azimut = obtenir_azimut_soleil(LATITUDE, LONGITUDE)

-- 2. Facteur d'orientation / ombrage dynamique selon l'azimut solaire (Sud = 180°)
local facteur_orientation_ombrage = 0.80

if azimut < 125 then
	-- Soleil en debut de matinee (Est) : fort ombrage sur AutoConso
	facteur_orientation_ombrage = 0.25
elseif azimut < 145 then
	facteur_orientation_ombrage = 0.35
elseif azimut < 165 then
	facteur_orientation_ombrage = 0.60
elseif azimut >= 165 and azimut <= 240 then
        -- Soleil autour du Sud / Plein milieu de journee
	facteur_orientation_ombrage = 1.00
elseif azimut > 240 and azimut <= 265 then
        -- Fin d'apres-midi (Sud-Ouest) : avantage aux panneaux AutoConso
	facteur_orientation_ombrage = 1.15
elseif azimut > 265 and azimut <= 290 then
        -- Soiree (Ouest) : fort avantage AutoConso (soleil rasant)
	facteur_orientation_ombrage = 1.35
else
	facteur_orientation_ombrage = 0.80
end

    -- 3. Corrections thermiques (-0.4%/°C par rapport a 25°C)
local corr_temp_ext = 1 + (-0.004 * (ExterieurTemperature:getVal() - 25))
local corr_temp_comble = 1 + (-0.004 * (CombleTemperature:getVal() - 25))

    -- 4. Puissance theorique AutoConso
local k_base = 0.58
local PTheoretical = ProdPower:getVal() * k_base * (corr_temp_ext / corr_temp_comble) * facteur_orientation_ombrage
    
PTheoretical = math.floor(PTheoretical + 0.5)

-- print("Theorique :", PTheoretical)

SimulAutoConsoPower:Publish(PTheoretical)
