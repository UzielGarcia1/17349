DECLARE @RC int 
DECLARE @region_id int = 1

EXECUTE @RC = [dbo].[sps_region]
    @region_id