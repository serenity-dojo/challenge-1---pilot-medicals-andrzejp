Feature: Medical certificate expiry rules

  As a pilot
  I want to know what will happen when my medical certificate expires
  So that I exercise the right level of privileges

  Rule: A 1st or second class license that expires drops to a lower level and gets a new expiration date
    Scenario Outline:
      Given Peter is a <Class> pilot born on <Birth Date>
      When his last medical was on <Medical Date>
      And today is <Today's Date>
      Then his license should now be <New Class>
      And be valid until <New Expiration Date>

      Examples: Under 40
        | Class     | Birth Date     | Medical Date   | Today's Date    | New Class | New Expiration Date |
        | 1st class | 1 January 1990 | 1 January 2020 | 1 February 2021 | 3rd class | 31 January 2025     |
        | 2nd class | 1 January 1990 | 1 January 2020 | 1 February 2021 | 3rd class | 31 January 2025     |

      Examples: Over 40
        | Class     | Birth Date     | Medical Date   | Today's Date    | New Class | New Expiration Date |
        | 1st class | 1 January 1970 | 1 January 2020 | 1 August 2020   | 2nd class | 31 January 2021     |
        | 2nd class | 1 January 1970 | 1 January 2020 | 1 February 2021 | 3rd class | 31 January 2022     |

  Rule: A 3rd class licence that expires cannot be used to fly
    Scenario Outline:
      Given Terry is a 3rd class pilot born on <Birth Date>
      When his last medical was on <Medical Date>
      And today is <Today's Date>
      Then his license should now be expired

      Examples:
        | Birth Date     | Medical Date   | Today's Date    | Note              |
        | 1 January 1990 | 1 January 2020 | 1 February 2025 | Terry is under 40 |
        | 1 January 1970 | 1 January 2020 | 1 February 2022 | Terry is over 40  |