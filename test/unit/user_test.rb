require 'test_helper'

class UserTest < ActiveSupport::TestCase

  ####Username Validations
  #Test empty username
  def test_should_not_create_user_with_empty_username
    user = build_user("","111111", "111111","validemail@domain.com")
    assert !user.save, "Saved user with empty username"
  end


  #Test username too short (min=5)
  def test_should_not_create_user_with_short_username
    user = build_user("tr", "111111", "111111","validemail@domain.com")
    assert !user.save, "Saved user with username too short"
  end


  #Test username too long (min=150)
  def test_should_not_create_user_with_long_username
    user = build_user("TravisIsSoCoolThatHeActuallyFilledThisInWithAnActualMessageInsteadOfJustTypingInRandomStuff,AlthoughThisIsALittleRandom...", "111111", "111111","validemail@domain.com")
    assert !user.save, "Saved user with password too long"
  end

  ####Email Validations
  #Test invalid email
  def test_should_not_create_with_invalid_email
    user = build_user("travis", "111111", "11111111","domain.com")
    assert !user.save, "Saved user with invalid email"
  end


  #Test existing emails
  def test_should_not_create_used_email
    user = build_user("travis", "11111111", "11111111","email2@gmail.com")
    assert !user.save, "Saved user with duplicated email"

  end

  #Test no email
  def test_should_not_create_with_no_email
    user = build_user("travis", "11111111", "11111111","")
    assert !user.save, "Saved user with no email"
  end


  ### Password Validators
  #Test different passwords
  def test_should_not_create_user_with_different_passwords
    user = build_user("travis","11111111", "11111112","validemail@domain.com")
    assert !user.save, "Saved user with different passwords"
  end

  #Test empty passwords
  def test_should_not_create_user_with_empty_passwords
    user = build_user("travis","", "","validemail@domain.com")
    assert !user.save, "Saved user with different passwords"
  end


  #Test password too short (min=5)
  def test_should_not_create_user_with_short_password
    user = build_user("travis", "1111", "1111","validemail@domain.com")
    assert !user.save, "Saved user with password too short"
  end


  #Test password too long (min=150)
  def test_should_not_create_user_with_long_passwords
    user = build_user("travis", "1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111", "1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111","validemail@domain.com")
    assert !user.save, "Saved user with password too long"
  end

  ##Test Create ok
  def test_should_create_user
    user = build_user("travis", "mypassword","mypassword","validmail@adomain.com")
    assert user.save, "The user should have been saved"
  end

  #Private methods
  private
  def build_user(username, password, password_confirmation,email)
    user = User.new
    user.username=username
    user.password=password
    user.password_confirmation = password_confirmation
    user.email = email
    user
  end
end

