require 'helper'
require 'toolbox/array'
require 'representations/person'

class TestToolboxArray < Test::Unit::TestCase

  PERSONS_ENTITY1 = [
    {
      'first_name' => 'C',
      'last_name' => 'D',
      'email' => 'CD@proofpoint.com',
      'addresses' => [
        'address1' => '12345 Foobar Way'
      ]
    },
    {
      'first_name' => 'A',
      'last_name' => 'B',
      'email' => 'AB@proofpoint.com'
    }
  ]
  PERSONS_ENTITY2 = [
    {
      'first_name' => 'E',
      'last_name' => 'F',
      'email' => 'EF@proofpoint.com',
      'addresses' => [
        'address1' => '6789 Hello World Dr.',
        'city' => 'Sunnyvale',
        'state' => 'CA',
        'zip' => '94536'
      ]
    },
    {
      'first_name' => 'C',
      'last_name' => 'D',
      'email' => 'CD@proofpoint.com',
      'addresses' => [
        'address1' => '12345 Foobar Way'
      ]
    },
    {
      'first_name' => 'A',
      'last_name' => 'B',
      'email' => 'AB@proofpoint.com'
    }
  ]
  PERSONS1 = PERSONS_ENTITY1.inject([]) { |result, person_entity| result << Person.new(person_entity); result }
  PERSONS2 = PERSONS_ENTITY2.inject([]) { |result, person_entity| result << Person.new(person_entity); result }

  should 'be able to validate whether two arrays are the same' do
    persons1 = PERSONS1.dup
    persons1.sort!
    persons2 = PERSONS1.dup

    assert_equal false, persons1 == persons2, 'Expect that a sorted and an unsorted array should not equal each other'
    assert_equal true, persons1 =~ persons2, 'Expect that sorted and an unsorted array with =~ equivalence check should be equal (regardless of order)'
    assert_equal true, persons2 =~ persons1, 'Expect that sorted and an unsorted array (inverse) with =~ equivalence check should be equal (regardless of order)'
  end

  should 'be able to validate whether elements in persons1 are contained in persons2' do
    persons1 = PERSONS1.dup
    persons1.sort!
    persons2 = PERSONS2.dup

    assert_equal false, persons1 == persons2, 'Expect that two arrays with similar objects should not equal each other'
    assert_equal false, persons1 =~ persons2, 'Expect that persons2 array is not contained in persons1 array'
    assert_equal true, persons2 =~ persons1, 'Expect that persons1 array is contained in persons2 array'
  end

  should 'be able to validate whether element is contained in an array' do
    person_exist = PERSONS2[1].dup
    person_not_exist = PERSONS2[0].dup
    persons = PERSONS1.dup

    assert_equal false, persons =~ person_not_exist, 'Expect that EF@proofpoint.com does not exist in persons array'
    assert_equal true, persons =~ person_exist, 'Expect that CD@proofpoint.com exists in persons array'
  end

  should 'be able to validate whether two arrays are the same (with alias method contains?)' do
    persons1 = PERSONS1.dup
    persons1.sort!
    persons2 = PERSONS1.dup

    assert_equal false, persons1 == persons2, 'Expect that a sorted and an unsorted array should not equal each other'
    assert_equal true, persons1.contains?(persons2), 'Expect that sorted and an unsorted array with =~ equivalence check should be equal (regardless of order)'
    assert_equal true, persons2.contains?(persons1), 'Expect that sorted and an unsorted array (inverse) with =~ equivalence check should be equal (regardless of order)'
  end

  should 'be able to validate whether elements in persons1 are contained in persons2 (with alias method contains?)' do
    persons1 = PERSONS1.dup
    persons1.sort!
    persons2 = PERSONS2.dup

    assert_equal false, persons1 == persons2, 'Expect that two arrays with similar objects should not equal each other'
    assert_equal false, persons1.contains?(persons2), 'Expect that persons2 array is not contained in persons1 array'
    assert_equal true, persons2.contains?(persons1), 'Expect that persons1 array is contained in persons2 array'
  end

  should 'be able to validate whether element is contained in an array (with alias method contains?)' do
    person_exist = PERSONS2[1].dup
    person_not_exist = PERSONS2[0].dup
    persons = PERSONS1.dup

    assert_equal false, persons.contains?(person_not_exist), 'Expect that EF@proofpoint.com does not exist in persons array'
    assert_equal true, persons.contains?(person_exist), 'Expect that CD@proofpoint.com exists in persons array'
  end

end