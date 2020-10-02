module SignupHelper

  def judge_exception(model,hash)
    if model.errors.details[hash].present? && model.errors.messages[hash].include?("is reserved")
      return true
    else
      return false
    end
  end

  def judge_blank(model,hash)
    if model.errors.details[hash].present? && model.errors.messages[hash].include?("can't be blank")
      return true
    else
      return false
    end
  end

  def judge_format(model,hash)
    if model.errors.details[hash].present? && model.errors.messages[hash].include?("is invalid")
      return true
    else
      return false
    end
  end

  def judge_length_short(model,hash,num)
    if model.errors.details[hash].present? && model.errors.messages[hash].include?("is too short (minimum is #{num} characters)")
      return true
    else
      return false
    end
  end

  def judge_length_long(model,hash,num)
    if model.errors.details[hash].present? && model.errors.messages[hash].include?("is too long (maximum is #{num} characters)")
      return true
    else
      return false
    end
  end
  
  def judge_password_match(model,hash)
    if model.errors.details[hash].present? && model.errors.messages[hash].include?("doesn't match Password")
      return true
    else
      return false
    end
  end

  def judge_date_present(model,one,two,three)
    if model.errors.details[one].present? || model.errors.details[two].present? || model.errors.details[three].present?
      return true
    else
      return false
    end
  end

  def judge_recaptcha(model)
    if model.errors.details[:base].present? && model.errors.messages[:base].include?("reCAPTCHA verification failed, please try again.")
      return true
    else
      return false
    end
  end

end
