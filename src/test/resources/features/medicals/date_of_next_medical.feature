Feature: Determining when a pilot is due for a medical examination

  As a pilot
  I want to know when my medical certificate will expire
  So that I can renew my certificate at the right time and comply with FAA regulations

  Rule: Certificates for 1st class licenses expire after 12 months for pilots under 40 and 6 months for pilots over 40
    Background:
      Given Fran is a 1st class pilot

    Example: Fran is over 40 on the date of her exam
      Given she was born on 3 June 1980
      When she has a medical exam on 5 March 2023
      Then her medical certificate will expire on 30 September 2023

    Example: Fran is under 40 on the date of her exam
      Given she was born on 1 March 2000
      When she has a medical exam on 20 December 2023
      Then her medical certificate will expire on 31 December 2024

  Rule: Certificates for 2st class licenses expire after 12 months
    Background:
      Given Stan is a 2nd class pilot

    Example: Stan is over 40 on the date of his exam
      Given he was born on 1 April 1970
      When he has a medical exam on 1 January 2022
      Then his medical certificate will expire on 31 January 2023

    Example: Stan is under 40 on the date of his exam
      Given he was born on 7 August 1998
      When he has a medical exam on 12 December 2023
      Then his medical certificate will expire on 31 December 2024

  Rule: Certificates for 3rd class licenses expire after 2 years for pilots over 40 and after 5 years for pilots under 40
    Background:
      Given Terry is a 3rd class pilot

    Example: Terry is over 40 on the date of his exam
      Given he was born on 2 February 1983
      When he has a medical exam on 3 June 2023
      Then his medical certificate will expire on 30 June 2025

    Example: Terry is under 40 on the date of his exam
      Given he was born on 1 September 2000
      When he has a medical exam on 12 December 2023
      Then his medical certificate will expire on 31 December 2028