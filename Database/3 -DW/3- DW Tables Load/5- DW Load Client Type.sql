USE [DB_DW]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP PROCEDURE IF EXISTS [dbo].[dw_l_clients_type]
GO
 

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dw_l_clients_type]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dw_l_clients_type] AS' 
END
GO

ALTER PROCEDURE  [dbo].[dw_l_clients_type]
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
 
            -- Actualizacion de registros
            UPDATE [dbo].[dim_client_type]
               SET [fecha_hasta] = X.[fecha_hasta]
                  ,[fec_ult_act] = getdate()
                  ,[usr_ult_act] = suser_sname() 
              FROM (SELECT [client_type_sk_id],
                           [fecha_hasta]
                      FROM [DB_STAGE].[dbo].[stg_client_type]
                   ) X
             WHERE [dbo].[dim_client_type].[client_type_sk_id] = X.[client_type_sk_id]
               AND IsNull([dbo].[dim_client_type].[fecha_hasta], '1800-01-01') <> X.[fecha_hasta] 

			-- Inserta los datos modificados / nuevos
			INSERT INTO [dbo].[dim_client_type]
       			 (  [client_type_sk_id],
                    [cliente_type_description],
					[fecha_desde],
					[fecha_hasta],
					[fec_ult_act],
					[usr_ult_act]					
					)
           SELECT   [client_type_sk_id],
                    [client_type_description],
					[fecha_desde],
					[fecha_hasta]
       				 ,getdate() AS [fec_ult_act]
       				 ,SYSTEM_USER AS [usr_ult_act]
             FROM [DB_STAGE].[dbo].[stg_client_type] STG
            WHERE NOT EXISTS (SELECT 1 FROM [dbo].[dim_client_type] DIM WHERE DIM.client_type_sk_id = STG.client_type_sk_id)
  
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


