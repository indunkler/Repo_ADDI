USE [DB_STAGE]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


DROP PROCEDURE IF EXISTS [dbo].[stg_load_clients]
GO
 

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[stg_load_clients]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[stg_load_clients] AS' 
END
GO

 
ALTER PROCEDURE [dbo].[stg_load_clients]
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
           UPDATE [DB_STAGE].[dbo].[stg_clients]
              SET [fecha_hasta] = getdate()
                 ,[fec_ult_act] = getdate()
                 ,[usr_ult_act] = suser_sname() 
             FROM (
           SELECT DISTINCT 
       			  A.client_id as cliente_src_id,
				  A.cupo_state,
				  A.remaining_cupo
			 FROM [DB_SOURCE].[dbo].[SRC_Clients] A
       			) X
   			  WHERE [DB_STAGE].[dbo].[stg_clients].[cliente_src_id] = X.[cliente_src_id]
			   AND ([DB_STAGE].[dbo].[stg_clients].[remaining_cupo] <> X.[remaining_cupo] OR
					[DB_STAGE].[dbo].[stg_clients].[cupo_state] <> x.cupo_state
    				)
				AND [fecha_hasta] IS NULL
		
		 
    		-- Inserta los datos modificados / nuevos
    	   INSERT INTO [DB_STAGE].[dbo].[stg_clients]
       			 ([cliente_sk_id]
       			 ,[cliente_src_id]
       			 ,[cupo_state]
				 ,[remaining_cupo]
       			 ,[fecha_desde]
				 ,[fecha_hasta]
				 ,[usr_ult_act]
				 ,[fec_ult_act]
      		   )
      		   SELECT NEXT VALUE FOR [dbo].[seq_Cliente] [cliente_sk_id], *
			   FROM
       			 ( SELECT DISTINCT 
       			  A.client_id as cliente_src_id,
				  A.cupo_state as cupo_state,
				  A.remaining_cupo as remaining_cupo
       			 ,getdate() AS [fecha_desde]
       			 ,null AS [FechaHasta]
       			 ,SYSTEM_USER AS [usr_ult_act]
       			 ,getdate() AS [fec_ult_act]
       			 FROM [DB_SOURCE].[dbo].[SRC_Clients] A 
       			   ) X
				 WHERE NOT EXISTS (SELECT 1 
									 FROM [dbo].[stg_clients] Z 
									WHERE Z.[cliente_src_id] = X.[cliente_src_id] 								  
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