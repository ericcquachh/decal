Feature: Adding cofacilitator
	As a facilitator
	I want to be able to add other students
	So they can also be cofacilitators for my course

Background: Facilitator has logged in
	When I sign in as a facilitator
	And the following students exist:
		| email                      | first_name | last_name | facilitator | access  |
		| jetli@berkeley.edu         | jet        | li        | f           | student |
		| pierceoeflein@berkeley.edu | pierce     | oeflein   | f           | student |
		| samanthayin@berkeley.edu   | samantha   | yin       | f           | student |
	And the following courses exist:
		| title                    | category           | units | time            | status |
		| Quantum Consciousness    | Cognitive Science  | 2     | TuTh 5PM-6PM    | Open   |
	And the following sections exist:
		| section_title       | facilitator | size | course_id |
		| Sleeping with Dogs  |             | 40   | 1         |
		| Sleeping with Cats  |             | 40   | 1         |
		| Sleeping with Birds |             | 40   | 2         |
	Then I visit facilitate course page

Scenario: Facilitator can search and approve a student
	Given I am on the facilitate course page
	When I search for: Jet Li
	And I select "Quantum Consciousness"
	And I press "Approve"
	Then Jet Li is now a facilitator for my course

Scenario: Facilitator should not find a non-existent student
	Given I am on the facilitate course page
	When I search for: John Lennon
	Then I should not see John Lennon

Scenario: Facilitator can add student as facilitator to section
	Given I am on the facilitate course page
	When I search for: Pierce Oeflein
	Then I select "Quantum Consciousness"
	Then I select "Sleeping with Dogs"
	Then I should not see "Sleeping with Birds"
	And I press "Approve"
	Then Pierce Oeflein is now a facilitator for my section
