DECLARE @PatternName nvarchar(50) = 'PassportNumber'
DECLARE @Pattern nvarchar(4000) = '[A-PR-WY][1-9]\d\s?\d{4}[1-9]'

EXECUTE [Regex].[STP_CreateRegexPattern] 
   @PatternName
  ,@Pattern
GO
DECLARE @PatternName nvarchar(50) = 'PostalCode_DK'
DECLARE @Pattern nvarchar(4000) = '\d{4}'

EXECUTE [Regex].[STP_CreateRegexPattern] 
   @PatternName
  ,@Pattern
GO
DECLARE @PatternName nvarchar(50) = 'PostalCode_GB'
DECLARE @Pattern nvarchar(4000) = 'GIR[ ]?0AA|((AB|AL|B|BA|BB|BD|BH|BL|BN|BR|BS|BT|CA|CB|CF|CH|CM|CO|CR|CT|CV|CW|DA|DD|DE|DG|DH|DL|DN|DT|DY|E|EC|EH|EN|EX|FK|FY|G|GL|GY|GU|HA|HD|HG|HP|HR|HS|HU|HX|IG|IM|IP|IV|JE|KA|KT|KW|KY|L|LA|LD|LE|LL|LN|LS|LU|M|ME|MK|ML|N|NE|NG|NN|NP|NR|NW|OL|OX|PA|PE|PH|PL|PO|PR|RG|RH|RM|S|SA|SE|SG|SK|SL|SM|SN|SO|SP|SR|SS|ST|SW|SY|TA|TD|TF|TN|TQ|TR|TS|TW|UB|W|WA|WC|WD|WF|WN|WR|WS|WV|YO|ZE)(\d[\dA-Z]?[ ]?\d[ABD-HJLN-UW-Z]{2}))|BFPO[ ]?\d{1,4}'

EXECUTE [Regex].[STP_CreateRegexPattern] 
   @PatternName
  ,@Pattern
GO
DECLARE @PatternName nvarchar(50) = 'PostalCode_US'
DECLARE @Pattern nvarchar(4000) = '\d{5}([ \-]\d{4})?'

EXECUTE [Regex].[STP_CreateRegexPattern] 
   @PatternName
  ,@Pattern
GO
DECLARE @PatternName nvarchar(50) = 'PostalCode_DE'
DECLARE @Pattern nvarchar(4000) = '\d{5}'

EXECUTE [Regex].[STP_CreateRegexPattern] 
   @PatternName
  ,@Pattern
GO
DECLARE @PatternName nvarchar(50) = 'PostalCode_CA'
DECLARE @Pattern nvarchar(4000) = '[ABCEGHJKLMNPRSTVXY]\d[ABCEGHJ-NPRSTV-Z][ ]?\d[ABCEGHJ-NPRSTV-Z]\d'

EXECUTE [Regex].[STP_CreateRegexPattern] 
   @PatternName
  ,@Pattern
GO
DECLARE @PatternName nvarchar(50) = 'FileNameWith3LetterExtension'
DECLARE @Pattern nvarchar(4000) = '[\w,\s-]+\.[A-Za-z]{3}'

EXECUTE [Regex].[STP_CreateRegexPattern] 
   @PatternName
  ,@Pattern
GO
DECLARE @PatternName nvarchar(50) = 'IPv4Address'
DECLARE @Pattern nvarchar(4000) = '(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])'

EXECUTE [Regex].[STP_CreateRegexPattern] 
   @PatternName
  ,@Pattern
GO
DECLARE @PatternName nvarchar(50) = 'IPv6Address'
DECLARE @Pattern nvarchar(4000) = '(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))'

EXECUTE [Regex].[STP_CreateRegexPattern] 
   @PatternName
  ,@Pattern
GO
DECLARE @PatternName nvarchar(50) = 'IPv4Andv6Address'
DECLARE @Pattern nvarchar(4000) = '((^\s*((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))\s*$)|(^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$))'

EXECUTE [Regex].[STP_CreateRegexPattern] 
   @PatternName
  ,@Pattern
GO
DECLARE @PatternName nvarchar(50) = 'StringLowercaseMin3Letters'
DECLARE @Pattern nvarchar(4000) = '[a-z0-9_-]{3,16}'

EXECUTE [Regex].[STP_CreateRegexPattern] 
   @PatternName
  ,@Pattern
GO
DECLARE @PatternName nvarchar(50) = 'EmailSimpleOnly'
DECLARE @Pattern nvarchar(4000) = '([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6})*'

EXECUTE [Regex].[STP_CreateRegexPattern] 
   @PatternName
  ,@Pattern
GO
