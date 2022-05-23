Feature: check forms

  Scenario Outline: Handling invalid question form submission

    * driver 'https://www.bbc.com/news/52143212'
    * maximize()

    * def form = "//div[@class='embed-content-container']"

    * input(form + "//textarea[contains(@placeholder,'What')]", <question>)
    * input(form + "//input[contains(@placeholder,'Name')]", <name>)
    * input(form + "//input[contains(@placeholder,'Email')]", <email>)
    * input(form + "//input[contains(@placeholder,'Contact')]", <number>)
    * input(form + "//input[contains(@placeholder,'Location')]", <location>)
    * input(form + "//input[contains(@placeholder,'Age')]", <age>)
    * click(form + "//input[@type='checkbox']")
    * click(form + "//button[@class='button']")

    * def errorMsg = text(form + "//div[@class='input-error-message']")
    * match errorMsg == <error>

    Examples:
      | question | name   | email  | number | location | age    | error                           |
      | ''       | 'some' | 'some' | 'some' | 'some'   | 'some' | ' can\'t be blank'              |
      | 'some'   | ''     | 'some' | 'some' | 'some'   | 'some' | 'Name can\'t be blank'          |
      | 'some'   | 'some' | ''     | 'some' | 'some'   | 'some' | 'Email address can\'t be blank' |
