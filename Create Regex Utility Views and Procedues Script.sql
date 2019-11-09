SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE SCHEMA Regex
GO
-- =============================================
-- Author: Lars Shakya Buch-Jepsen
-- Create date: 2019-11-01
-- Description: List Regex Pattern
-- =============================================
CREATE VIEW [Regex].[View_ListRegexPatterns]
AS
SELECT        xml_collection_id AS PatternId, name AS PatternName, create_date AS CreateDate, modify_date AS ModifiedDate
FROM            sys.xml_schema_collections
WHERE        schema_id = SCHEMA_ID('Regex')
GO
 -- =============================================
 -- Author: Lars Shakya Buch-Jepsen
 -- Create date: 2019-11-01
 -- Description: Create Regex Pattern and function for it
 -- =============================================
 CREATE PROCEDURE [Regex].[STP_CreateRegexPattern]
	@PatternName NVARCHAR(50),
	@Pattern NVARCHAR(4000)
 AS
 BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	BEGIN TRANSACTION

	BEGIN TRY

		IF(CHARINDEX(' ',@PatternName ) > 0)
		BEGIN
			DECLARE @SpaceErrorMessage NVARCHAR(200) 
			SET @SpaceErrorMessage = 'The pattern name ' + @PatternName + ' contains space ( )'
			RAISERROR(@SpaceErrorMessage,16,1)
		END

		IF EXISTS(
				SELECT [PatternId]
					,[PatternName]
					,[CreateDate]
					,[ModifiedDate]
				FROM [Regex].[View_ListRegexPatterns]
				WHERE PatternName = @PatternName
				)
		BEGIN
			DECLARE @PatternNameExistsErrorMessage NVARCHAR(200) 
			SET @PatternNameExistsErrorMessage = 'The pattern name ' + @PatternName + ' already exists'
			RAISERROR(@PatternNameExistsErrorMessage,16,1)
		END

		IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Regex].' + @PatternName)
			AND type in (N'FN', N'IF',N'TF', N'FS', N'FT'))
		BEGIN
			DECLARE @FunctionExistsErrorMessage NVARCHAR(200) 
			SET @FunctionExistsErrorMessage = 'The function name ' + @PatternName + ' already exists'
			RAISERROR(@FunctionExistsErrorMessage,16,1)
		END

		DECLARE @sql NVARCHAR(MAX) =
		'CREATE XML SCHEMA COLLECTION Regex.' + @PatternName + '
		AS''<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema">
			<xsd:element name="x">
				<xsd:simpleType>
					<xsd:restriction base="xsd:token">
						<xsd:pattern value="' + @Pattern + '"/>
					</xsd:restriction>
				</xsd:simpleType>
			</xsd:element>
		</xsd:schema>'''

		EXEC (@sql)

		SET @sql = 
		'CREATE FUNCTION [Regex].' + @PatternName + '
		(
			@CheckTest NVARCHAR(4000)
		)
		RETURNS BIT
		WITH SCHEMABINDING
		AS
		BEGIN
			DECLARE @x XML(Regex.' + @PatternName + ')
			DECLARE @Result BIT

			SET @x = ''<x>'' + @CheckTest + ''</x>''
	
			SET @Result = 1
			RETURN @Result
		END'

		EXEC (@sql)
		
		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		DECLARE @ErrorLine INT
		DECLARE @ErrorLineAsText NVARCHAR(10)
		DECLARE @ErrorProcedure NVARCHAR(255)
		DECLARE @ErrorMessage NVARCHAR(4000)

		-- Get error text
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @ErrorLine = ERROR_LINE ()
		SET @ErrorProcedure = OBJECT_NAME(@@PROCID)
		SET @ErrorMessage = ERROR_MESSAGE()

		-- Concatinate errorline and error function if existing
		IF @ErrorLine IS NOT NULL AND @ErrorProcedure IS NOT NULL
		BEGIN
		SET @ErrorLineAsText = CAST(@ErrorLine AS NVARCHAR(10))
		SET @ErrorMessage = 'Procedure/Function: ' + @ErrorProcedure + ' Line: ' + @ErrorLineAsText + ' Message: ' + @ErrorMessage
		END

		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
		PRINT
		N'The transaction is in an uncommittable state.' +
		'Rolling back transaction.'
		ROLLBACK TRANSACTION;
		END;

		-- Test whether the transaction is committable.
		IF (XACT_STATE()) = 1
		BEGIN
		PRINT
		N'The transaction is committable.' +
		'Committing transaction.'
		COMMIT TRANSACTION;
		END;

		-- Use RAISERROR to make exception that gives detailed message
		-- other message that SqlException to the users of the procedure
		-- and uncomment to log to the application log using WITH LOG
		RAISERROR(@ErrorMessage,@ErrorSeverity, @ErrorState) -- WITH LOG
	END CATCH;
END
GO
-- =============================================
-- Author:		Lars Shakya Buch-Jepsen
-- Create date: 2019-11-01
-- Description:	Deletes specific function and its pattern
-- =============================================
CREATE PROCEDURE [Regex].[STP_DeleteRegexPattern]
   @PatternName NVARCHAR(50)
 AS
 BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	BEGIN TRANSACTION

	BEGIN TRY

		DECLARE @sql NVARCHAR(MAX) =
		'IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[Regex].' + @PatternName + ''')
			AND type in (N''FN'', N''IF'',N''TF'', N''FS'', N''FT''))
		BEGIN
			DROP FUNCTION [Regex].' + @PatternName + '
		END'

		EXEC (@sql)

		SET @sql =
		'IF EXISTS(  
			SELECT * FROM sys.xml_schema_collections   
			WHERE name = ''' + @PatternName + ''' 
			AND schema_id = SCHEMA_ID(''Regex''))
		 BEGIN  
			DROP XML SCHEMA COLLECTION Regex.' + @PatternName + ' 
		END'

		EXEC (@sql)

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		DECLARE @ErrorLine INT
		DECLARE @ErrorLineAsText NVARCHAR(10)
		DECLARE @ErrorProcedure NVARCHAR(255)
		DECLARE @ErrorMessage NVARCHAR(4000)

		-- Get error text
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @ErrorLine = ERROR_LINE ()
		SET @ErrorProcedure = OBJECT_NAME(@@PROCID)
		SET @ErrorMessage = ERROR_MESSAGE()

		-- Concatinate errorline and error function if existing
		IF @ErrorLine IS NOT NULL AND @ErrorProcedure IS NOT NULL
		BEGIN
		SET @ErrorLineAsText = CAST(@ErrorLine AS NVARCHAR(10))
		SET @ErrorMessage = 'Procedure/Function: ' + @ErrorProcedure + ' Line: ' + @ErrorLineAsText + ' Message: ' + @ErrorMessage
		END

		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
		PRINT
		N'The transaction is in an uncommittable state.' +
		'Rolling back transaction.'
		ROLLBACK TRANSACTION;
		END;

		-- Test whether the transaction is committable.
		IF (XACT_STATE()) = 1
		BEGIN
		PRINT
		N'The transaction is committable.' +
		'Committing transaction.'
		COMMIT TRANSACTION;
		END;

		-- Use RAISERROR to make exception that gives detailed message
		-- other message that SqlException to the users of the procedure
		-- and uncomment to log to the application log using WITH LOG
		RAISERROR(@ErrorMessage,@ErrorSeverity, @ErrorState) -- WITH LOG
	END CATCH;
END
GO
