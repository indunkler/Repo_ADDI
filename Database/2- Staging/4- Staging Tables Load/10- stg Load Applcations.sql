USE [DB_STAGE]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


DROP PROCEDURE IF EXISTS [dbo].[stg_load_applications]
GO
 

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[stg_load_applications]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[stg_load_applications] AS' 
END
GO

 
ALTER PROCEDURE [dbo].[stg_load_applications]
AS    
BEGIN  

	-- Variables de banda negativa
	DECLARE @FechaNulo varchar(8000) = convert(date,'01/01/1800')
	DECLARE @IdTextoNulo varchar(8000) = '-1'
	DECLARE @IdNumericoNulo int = -1

 
 
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
    	   INSERT INTO [DB_STAGE].[dbo].[stg_applications]
       			 ([application_sk_id],
				  [application_id],
				  [loan_id],
                  [loan_originated],
                  [prospect_id],
                  [date_application],
                  [hour_application],
                  [first_dow_application],
                  [month_application], 
                  [quarter_application],
                  [product],
                  [client_type],
                  [amount],
                  [ally_slug],
                  [journey_name],
                  [journey_stage_name],
                  [learning_population],
                  [DPDplus31],
                  [DPDplus31_unpaid_principal],
                  [ally_brand],
				  [usr_ult_act],
				  [fec_ult_act]
      		   )
      		   SELECT NEXT VALUE FOR [dbo].[seq_Applications_Stage]  [application_sk_id], *
			   FROM
       			 ( SELECT DISTINCT 
				 A.application_id, 
				 ISNULL(A.loan_id, @IdTextoNulo) as loan_id,
				 ISNULL(A.loan_originated, @IdNumericoNulo) as loan_originated,
				 ISNULL(A.prospect_id, @IdTextoNulo) as prospect_id,
				 ISNULL(A.date_application, @IdTextoNulo) as date_application,
				 ISNULL(A.hour_application, @IdTextoNulo) as hour_application,
				 ISNULL(A.first_dow_application, @FechaNulo) as first_dow_application,
				 ISNULL(A.month_application, @IdTextoNulo) as month_application,
				 ISNULL(A.quarter_application, @IdTextoNulo) as quarter_application,
				 ISNULL(A.product,@IdTextoNulo) as product,
				 ISNULL(A.client_type, @IdTextoNulo) as client_type,
				 ISNULL(A.amount, @IdNumericoNulo) as amount,
				 ISNULL(A.ally_slug, @IdNumericoNulo) as ally_slug,
				 ISNULL(A.journey_name, @IdTextoNulo) as journey_name,
				 ISNULL(A.journey_stage_name, @IdTextoNulo) as journey_stage_name,
				 ISNULL(A.learning_population, @IdNumericoNulo) as learning_population,
				 ISNULL(A.DPDplus31, @IdNumericoNulo) as DPDplus31,
				 ISNULL(A.DPDplus31_unpaid_principal,@IdNumericoNulo) as  DPDplus31_unpaid_principal,
				 ISNULL(A.ally_brand, @IdNumericoNulo) as ally_brand,
       			 SYSTEM_USER AS [usr_ult_act],
       			 getdate() AS [fec_ult_act]
       			 FROM [DB_SOURCE].[dbo].[SRC_Applications] A 
       			   ) X
				 WHERE NOT EXISTS (SELECT 1 
									 FROM [DB_STAGE].[dbo].[stg_applications] Z 
									WHERE Z.[application_id] = X.[application_id] 								  
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