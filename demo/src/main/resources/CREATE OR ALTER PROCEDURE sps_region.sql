CREATE OR ALTER PROCEDURE sps_region
    @region_id INT 
AS
BEGIN
   SELECT 
        R.RegionDescription AS RegionName,
        T.TerritoryDescription AS TerritoryDescriptions
    FROM RRHH.Region R
    INNER JOIN RRHH.Territories T ON R.RegionID = T.RegionID
    WHERE (@region_id IS NULL OR R.RegionID = @region_id);

END
