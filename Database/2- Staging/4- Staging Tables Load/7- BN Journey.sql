USE [DB_STAGE]

BEGIN

INSERT INTO [dbo].[stg_journeys]
	(
		[journey_sk_id],
		[journey_description],
		[fecha_desde],
		[fecha_hasta],
		[usr_ult_act],
		[fec_ult_act]
	) VALUES
	(
		-1,
		'-1',
		'01/01/1800',
		'01/01/1800',
		'N/A',
	    '01/01/1800'
    )
END