USE [DB_DW]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP PROCEDURE IF EXISTS [dbo].[dw_l_datamart]
GO
 

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dw_l_datamart]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dw_l_datamart] AS' 
END
GO

ALTER PROCEDURE  [dbo].[dw_l_datamart]
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

		   TRUNCATE TABLE [DB_DW].[dbo].[dw_datamart]

 

			-- Inserta los datos modificados / nuevos application
			INSERT INTO [dbo].[dw_datamart]
       			 (  [loan_id],
					[loan_sk_id],
                    [loan_state],
					[loan_originated],
					[client_id],
					[cliente_cupo_state],
					[remaining_cupo],
					[client_sk],
					[date_sk],
					[datetime_app],
					[hour_app],
					[first_dow_app],
					[month_app],
					[quarter_app],
					[product_sk_id],
					[client_type_sk_id],
					[amount],
					[ally_slug],
					[journey_sk_id],
					[journey_stage_sk_id],
					[learning_population],
					[DPDplus31],
					[DPDplus31_unpaid_principal],
					[ally_brand]
					  )
                      SELECT 
						a.loan_id, 
						ISNULL(l.loan_sk_id, @IdNumericoNulo) as loan_sk_id, 
						ISNULL(l.state,@IdTextoNulo ) as loan_state,
						a.loan_originated, 
						a.prospect_id as cliente_id,
						cl.cupo_state as client_cupo_state,
						cl.remaining_cupo,
						cl.cliente_sk_id as cliente_sk,
						convert( int ,replace((left(a.date_application,10)),'-','')) as date_sk,
						a.[date_application] as datetime_app,
						a.[hour_application] as [hour_app],
						a.[first_dow_application] as[first_dow_app],
						a.[month_application] as [month_app],
						a.[quarter_application] as [quarter_app],
						p.product_sk_id, 
						ct.client_type_sk_id, 
						a.amount, 
						a.ally_slug, 
						ISNULL(jn.journey_sk_id,@IdNumericoNulo) as journey_sk_id, 
						ISNULL(jsn.journey_stage_sk_id, @IdNumericoNulo) as journey_stage_sk_id,
						a.learning_population, 
						a.DPDplus31,
						a.DPDplus31_unpaid_principal, 
						a.ally_brand
							FROM 
								 [DB_STAGE].[dbo].[stg_applications] a
								LEFT OUTER JOIN [DB_DW].[dbo].[dim_products] p ON a.product = p.product_description and p.fecha_hasta IS NULL
								LEFT OUTER JOIN [DB_DW].[dbo].[dim_client_type] ct ON a.client_type = ct.cliente_type_description  and ct.fecha_hasta IS NULL
								LEFT OUTER JOIN [DB_DW].[dbo].[dim_journeys] jn ON a.journey_name = jn.journey_description and jn.fecha_hasta IS NULL
								LEFT OUTER JOIN [DB_DW].[dbo].[dim_journeys_stage] jsn ON a.journey_stage_name = jsn.journey_stage_description and jsn.fecha_hasta IS NULL
								LEFT OUTER JOIN [DB_DW].[dbo].[dim_loans] l ON a.loan_id = l.loan_src_id and l.fecha_hasta IS NULL
								LEFT OUTER JOIN [DB_DW].[dbo].[dim_clients] cl ON a.prospect_id = cl.cliente_src_id and cl.fecha_hasta IS NULL
						

						-- Inserta los datos modificados / nuevos LOAN
						INSERT INTO [dbo].[dw_datamart]
       						 (  [loan_id],
								[loan_sk_id],
								[loan_state],
								[loan_originated],
								[client_id],
								[cliente_cupo_state],
								[remaining_cupo],
								[client_sk],
								[date_sk],
								[datetime_app],
								[hour_app],
								[first_dow_app],
								[month_app],
								[quarter_app],
								[product_sk_id],
								[client_type_sk_id],
								[amount],
								[ally_slug],
								[journey_sk_id],
								[journey_stage_sk_id],
								[learning_population],
								[DPDplus31],
								[DPDplus31_unpaid_principal],
								[ally_brand]
								  )
                  				  SELECT 
									a.loan_src_id as loan_id,
									a.loan_sk_id, 
									a.state as loan_state,
									@IdNumericoNulo as loan_originated, 
									@IdTextoNulo as cliente_id,
									@IdTextoNulo as client_cupo_state,
									@IdNumericoNulo as remaining_cupo,
									@IdNumericoNulo as cliente_sk,
									@IdNumericoNulo as date_sk,
									@IdTextoNulo as datetime_app,
									@IdTextoNulo as [hour_app],
									@FechaNulo as[first_dow_app],
									@IdTextoNulo as [month_app],
									@IdTextoNulo as [quarter_app],
									@IdTextoNulo as product_sk_id, 
									@IdTextoNulo as client_type_sk_id, 
									@IdNumericoNulo as amount, 
									@IdNumericoNulo as ally_slug, 
									@IdNumericoNulo as journey_sk_id, 
									@IdNumericoNulo as journey_stage_sk_id,
									@IdNumericoNulo as learning_population, 
									@IdNumericoNulo as DPDplus31,
									@IdNumericoNulo as DPDplus31_unpaid_principal, 
									@IdNumericoNulo as ally_brand
										FROM 
									[DB_DW].[dbo].[dim_loans] a
											WHERE a.fecha_hasta IS NULL
									AND NOT EXISTS
									(
									  SELECT 1 from [DB_DW].[dbo].[dw_datamart] b
									  WHERE a.loan_src_id = b.loan_id
									)


									-- Inserta los datos modificados / nuevos LOAN
						INSERT INTO [dbo].[dw_datamart]
       						 (  [loan_id],
								[loan_sk_id],
								[loan_state],
								[loan_originated],
								[client_id],
								[cliente_cupo_state],
								[remaining_cupo],
								[client_sk],
								[date_sk],
								[datetime_app],
								[hour_app],
								[first_dow_app],
								[month_app],
								[quarter_app],
								[product_sk_id],
								[client_type_sk_id],
								[amount],
								[ally_slug],
								[journey_sk_id],
								[journey_stage_sk_id],
								[learning_population],
								[DPDplus31],
								[DPDplus31_unpaid_principal],
								[ally_brand]
								  )
                  				  SELECT 
									@IdTextoNulo as loan_id,
									@IdNumericoNulo as loan_sk_id, 
									@IdTextoNulo as loan_state,
									@IdNumericoNulo as loan_originated, 
									a.cliente_src_id as cliente_id,
									a.cupo_state as client_cupo_state,
									a.remaining_cupo as remaining_cupo,
									@IdNumericoNulo as cliente_sk,
									@IdNumericoNulo as date_sk,
									@IdTextoNulo as datetime_app,
									@IdTextoNulo as [hour_app],
									@FechaNulo as[first_dow_app],
									@IdTextoNulo as [month_app],
									@IdTextoNulo as [quarter_app],
									@IdTextoNulo as product_sk_id, 
									@IdTextoNulo as client_type_sk_id, 
									@IdNumericoNulo as amount, 
									@IdNumericoNulo as ally_slug, 
									@IdNumericoNulo as journey_sk_id, 
									@IdNumericoNulo as journey_stage_sk_id,
									@IdNumericoNulo as learning_population, 
									@IdNumericoNulo as DPDplus31,
									@IdNumericoNulo as DPDplus31_unpaid_principal, 
									@IdNumericoNulo as ally_brand
										FROM 
									[DB_DW].[dbo].[dim_clients] a
											WHERE a.fecha_hasta IS NULL
									AND NOT EXISTS
									(
									  SELECT 1 from [DB_DW].[dbo].[dw_datamart] b
									  WHERE a.cliente_src_id = b.client_id
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


