@EPSAutomationSuite
Feature: AccountLookUp

  Background:
    Given that param "base_url.url" is set to value "https://tibintdevsac5p:19092/paymentservice/v1"

  @EPS_Automation
  Scenario Outline: Tokenization Authorization Capture PostAuthorization Returns
#***************** Tokenization *****************
    Given that param "xml_headers.Content-Type" is set to value "application/xml"
    When I read the XML from file /src/main/resources/testData/EPS/tokenization.xml with input values into Dictionary Key "Tokenization"
      | concept       | <concept>       |
      | orderID       | <orderID>       |
      | subCode       | <subCode>       |
      | accountNumber | <accountNumber> |
      | fullName      | <fullName>      |
      | year          | <year>          |
      | month         | <month>         |
    When I make a "POST" REST Call with URL "/tokenization" and Body from Dictionary Key "Tokenization" for xml
    Then I verify that the response code is "200" for the response with Dictionary Key "Tokenization" and get Token
#*****************  Authorization *****************
    Given that param "xml_headers.Content-Type" is set to value "application/xml"
    When I read the XML from file /src/main/resources/testData/EPS/authorization.xml with input values into Dictionary Key "Authorization" for Auth
      | concept       | <concept>       |
      | orderID       | <orderID>       |
      | subCode       | <subCode>       |
      | accountNumber | <accountNumber> |
      | fullName      | <fullName>      |
      | year          | <year>          |
      | month         | <month>         |
      | address       | <address>       |
      | city          | <city>          |
      | state         | <state>         |
      | postalCode    | <postalCode>    |
      | authAmt       | <authAmt>       |
    When I make a "POST" REST Call with URL "/cc/authorization" and Body from Dictionary Key "Authorization" for xml
    Then I verify that the response code is "200" for the response with Dictionary Key "Authorization" and get Auth Code and its MetaData
##*****************   Capture  *****************
    Given that param "xml_headers.Content-Type" is set to value "application/xml"
    When I read the XML from file /src/main/resources/testData/EPS/capture.xml with input values into Dictionary Key "Capture" for capture
      | concept       | <concept>       |
      | orderID       | <orderID>       |
      | subCode       | <subCode>       |
      | authAmt       | <authAmt>       |
    When I make a "POST" REST Call with URL "/cc/capture" and Body from Dictionary Key "Capture" for xml
    Then I verify that the response code is "200" for the response with Dictionary Key "Capture"
##*****************   PostAuthorization *****************
    Given that param "xml_headers.Content-Type" is set to value "application/xml"
    When I read the XML from file /src/main/resources/testData/EPS/postAuth.xml with input values into Dictionary Key "PostAuthorization" for postAuth
      | concept       | <concept>       |
      | orderID       | <orderID>       |
      | subCode       | <subCode>       |
      | authAmt       | <authAmt>       |
      | accountNumber | <accountNumber> |
      | fullName      | <fullName>      |
      | year          | <year>          |
      | month         | <month>         |
    When I make a "POST" REST Call with URL "/cc/postauthorization" and Body from Dictionary Key "PostAuthorization" for xml
    Then I verify that the response code is "200" for the response with Dictionary Key "PostAuthorization"
      ##*****************   Return *****************
    Given that param "xml_headers.Content-Type" is set to value "application/xml"
    When I read the XML from file /src/main/resources/testData/EPS/return.xml with input values into Dictionary Key "Return" for postAuth
      | concept       | <concept>       |
      | orderID       | <orderID>       |
      | subCode       | <subCode>       |
      | authAmt       | <authAmt>       |
      | accountNumber | <accountNumber> |
      | fullName      | <fullName>      |
      | year          | <year>          |
      | month         | <month>         |
    When I make a "POST" REST Call with URL "/cc/return" and Body from Dictionary Key "Return" for xml
    Then I verify that the response code is "200" for the response with Dictionary Key "Return"

    Examples:
      | concept | orderID      | subCode     | accountNumber    | fullName            | year | month | address              | city             | state | postalCode | authAmt |
      | WS      | 912292954069 | VISA/WSI/KR | 4688371306578143 | RIVA LESLIE         | 2025 | 12    | 1237 BALLINTON DR    | MELBOURNE        | FL    | 32940      | 37.63   |
      | WS      | 912292924069 | VISA/WSI/WS | 4688371069112353 | NILDA	BRANDENBURG   | 2025 | 11    | 1555 DUSTY CANYON ST | HENDERSON        | NV    | 89052      | 50.63   |
      | WS      | 912293924069 | VISA/WSI/PB | 4688371173084597 | ARCELIA CLARKE      | 2025 | 11    | 156 WINDSOR WAY      | MOSCOW           | PA    | 18444      | 60.63   |
      | WS      | 912294924069 | VISA/WSI/WE | 4688371237074253 | DELORES DAY         | 2025 | 12    | 1426 CITY ST         | UTICA            | NY    | 13502      | 70.63   |
      | WE      | 912295954069 | PLCC/WSI/KR | 6004301800448008 | PERCY PAINTER       | 2026 | 01    | 1216 N 14TH ST       | EAST SAINT LOUIS | IL    | 62205      | 80.63   |
      | WE      | 912296924069 | PLCC/WSI/PB | 6004301277585696 | ADRIENNE FILBY      | 2025 | 10    | 1005 W 23RD ST       | LOS ANGELES      | CA    | 90007      | 50.63   |
      | WE      | 912297924069 | PLCC/WSI/WE | 6004301156258746 | DEANDRA LACON       | 2026 | 01    | 172 HEMLOCK ST       | MANCHESTER       | NH    | 03104      | 60.63   |
      | WE      | 912298924069 | PLCC/WSI/WS | 6004301066753026 | FREDERIC KETTLEWELL | 2025 | 10    | 12753 YORK DR        | BATON ROUGE      | LA    | 70818      | 70.63   |