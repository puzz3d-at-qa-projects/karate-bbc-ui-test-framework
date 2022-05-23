Feature: check football results

  Scenario Outline: Match is on the Match overview page

    * driver 'https://bbc.com'
    * maximize()

    * def matchLocator =
  """
  "//div[@class='sp-c-fixture__wrapper'" +
  "and descendant::span[text()='" + <team1> + "']" +
  "and descendant::span[text()='" + <team2> + "']" +
  "and descendant::span[contains(@class,'home') and text()='" + <score1> + "']" +
  "and descendant::span[contains(@class,'away') and text()='" + <score2> + "']]"
  """
    * def teamName = matchLocator + "//span[text()='" + <team1> + "']"

    * click('{a}Sport')
    * click('{span}Football')
    * click('{a}Scores & Fixtures')
    * input('#downshift-0-input', <championship name>)
    * click('#downshift-0-item-0')
    * click("//a[contains(@href,<month>)]")
    * waitFor(matchLocator)
    * def matchOnThePage = exists(matchLocator)
    * if (!matchOnThePage) karate.fail('Match not found')
    * click(teamName)
    * waitFor(matchLocator)
    * def matchOnThePage = exists(matchLocator)
    * if (!matchOnThePage) karate.fail('Match not found')


    Examples:
      | championship name       | month     | team1          | score1 | score2 | team2         |
      | 'Premier League'        | '2022-03' | 'Arsenal'      | '0'    | '2'    | 'Liverpool'   |
      | 'Championship'          | '2022-02' | 'Blackpool'    | '4'    | '1'    | 'Reading'     |
      | 'Swiss Super League'    | '2021-10' | 'Lugano'       | '2'    | '1'    | 'Servette'    |
      | 'Scottish Championship' | '2022-01' | 'Raith Rovers' | '0'    | '0'    | 'Dunfermline' |
      | 'Spanish La Liga'       | '2021-12' | 'Sevilla'      | '1'    | '1'    | 'Barcelona'   |