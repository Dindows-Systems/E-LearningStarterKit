set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO

USE [ELearning]
GO

-- =============================================
-- Author:		<Alex Armijos>
-- Create date: <Octubre 16 2006>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[CortarPalabras]
(@palabra varchar(500),@cantidad_palabra bigint,@caracter varchar(5))
RETURNS varchar(500)
AS
BEGIN
	DECLARE @resultado varchar(500)
	DECLARE @palabra_auxiliar varchar(500)
	DECLARE @contador int	

	select @palabra_auxiliar=@palabra
	select @resultado=''
	
	if (@palabra is null) return null

	if (len(@palabra)<=@cantidad_palabra) return @palabra

	while (len(@palabra_auxiliar)>0)
	begin
		select @resultado=@resultado+substring(@palabra_auxiliar,1,@cantidad_palabra)

		if (len(@palabra_auxiliar)>@cantidad_palabra) 
		select @resultado=@resultado+@caracter

		select @palabra_auxiliar=substring(@palabra_auxiliar,@cantidad_palabra+1,len(@palabra_auxiliar))
	end

	
	RETURN @resultado

END
