Feature: check articles titles

  Background:
    * driver 'https://bbc.com'
    * maximize()
    * click('{a}News')

  Scenario: the News page displays the headline article

    * match text('//a/h3') == 'Russia firing during Mariupol evacuation - Ukraine forces'

  Scenario: The News page displays the promo articles

    * def promoArticles = "//div[contains(@class,'top-stories__secondary-item')]//h3"
    * def titles = ["US intelligence helped sink Russian warship - reports","Belarus plane arrest student jailed for six years","CCTV captures Kansas tornado churning in car park","Harry and Andrew will not appear on palace balcony","Israeli police hunt Palestinian axe killers"]

    * waitFor(promoArticles)
    * def gatheredTitles = locateAll(promoArticles)
    * match locateAll(promoArticles).map(x => x.text) == titles

  Scenario: The search by the news category name displays the given article

    * def headlineCategory = "//div[@data-entityid='container-top-stories#1']//a[contains(@class, 'section-link')]/span"
    * def searchResultsTitles = "//p[contains(@class,'PromoHeadline')]/span"
    * def title = "Europe: Strangers on My Doorstep"

    * waitFor(headlineCategory)
    * def query = text(headlineCategory)
    * submit().click('{^span}Search')
    * submit().input('#search-input', query + Key.ENTER)
    * waitForUrl(query)
    * match text(searchResultsTitles) == title
