USE [DB_STAGE]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


DROP PROCEDURE IF EXISTS [dbo].[stg_load_client_type]
GO
 

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[stg_load_client_type]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[stg_load_client_type] AS' 
END
GO

 
ALTER PROCEDURE [dbo].[stg_load_client_type]
AS    
BEGIN  
 
 
 -- Variables de error
 DECLARE @ErrorNumber INT; 
 DECLARE @ErrorMessage NVARCHAR(4000);  
 DECLARE @ErrorSeverity INT;  
 DECLARE @ErrorState INT; 
 DECLARE @ErrorProcedure NVARCHAR(4000);  
 DECLARE @ErrorLine INT; 
 
    BEGIN TRANSACTION
         BEGIN TRY
 

		 
    		-- Inserta los datos modificados / nuevos
    	   INSERT INTO [DB_STAGE].[dbo].[stg_client_type]
       			 ([client_type_sk_id]
       			 ,[client_type_description]
       			 ,[fecha_desde]
				 ,[fecha_hasta]
				 ,[usr_ult_act]
				 ,[fec_ult_act]
      		   )
      		   SELECT NEXT VALUE FOR [dbo].[seq_ClientType]   [client_type_sk_id], *
			   FROM
       			 ( SELECT DISTINCT 
				  A.client_type as client_type_description,
				  getdate() AS [fecha_desde]
       			 ,null AS [FechaHasta]
       			 ,SYSTEM_USER AS [usr_ult_act]
       			 ,getdate() AS [fec_ult_act]
       			 FROM [DB_SOURCE].[dbo].[SRC_Applications] A 
       			   ) X
				 WHERE NOT EXISTS (SELECT 1 
									 FROM [dbo].[stg_client_type] Z 
									WHERE Z.[client_type_description] = X.[client_type_description] 								  
									AND Z.fecha_hasta IS NULL
								   )
 
    
            COMMIT TRANSACTION
       END TRY
 
       BEGIN CATCH
           SELECT
               @ErrorNumber = ERROR_NUMBER(),
               @ErrorSeverity = ERROR_SEVERITY(),  
               @ErrorState = ERROR_STATE(),
               @ErrorProcedure = ERROR_PROCEDURE(),
               @ErrorLine = ERROR_LINE(),
               @ErrorMessage = ERROR_MESSAGE()
 
           ROLLBACK TRANSACTION
 
           RAISERROR (@ErrorMessage, -- Message text.  
               @ErrorSeverity, -- Severity.  
               @ErrorState -- State.  
               );
       END CATCH
END



GO