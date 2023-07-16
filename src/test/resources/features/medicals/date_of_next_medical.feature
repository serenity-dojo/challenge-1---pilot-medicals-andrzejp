Feature: Determining when a pilot is due for a medical examination

  As a pilot
  I want to know when my medical certificate will expire
  So that I can renew my certificate at the right time and comply with FAA regulations

  Rule: Certificates for 1st class licenses expire after 12 months for pilots under 40 and 6 months for pilots over 40
    Background:
      Given Fran is a 1st class pilot

    Example: Fran is over 40 on the date of her exam
      Given she was born on 03/06/1980
      When she has a medical exam on 05/03/2023
      Then her medical certificate will expire on 30/09/2023

    Example: Fran is under 40 on the date of her exam
      Given she was born on 01/03/2000
      When she has a medical exam on 20/12/2023
      Then her medical certificate will expire on 31/12/2024

  Rule: Certificates for 2st class licenses expire after 12 months
    Background:
      Given Stan is a 2nd class pilot

    Example: Stan is over 40 on the date of his exam
      Given he was born on 01/04/1970
      When he has a medical exam on 01/01/2022
      Then his medical certificate will expire on 31/01/2023

    Example: Stan is under 40 on the date of his exam
      Given he was born on 07/08/1998
      When he has a medical exam on 12/12/2023
      Then his medical certificate will expire on 31/12/2024

  Rule: Certificates for 3rd class licenses expire after 2 years for pilots over 40 and after 5 years for pilots under 40
    Background:
      Given Terry is a 3rd class pilot

    Example: Terry is over 40 on the date of his exam
      Given he was born on 02/02/1983
      When he has a medical exam on 03/06/2023
      Then his medical certificate will expire on 30/06/2025

    Example: Terry is under 40 on the date of his exam
      Given he was born on 01/09/2000
      When he has a medical exam on 12/12/2023
      Then his medical certificate will expire on 31/12/2028