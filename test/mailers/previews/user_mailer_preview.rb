# Preview all emails at https://5e096a3bde6c49998d0b927346b58f57.vfs.cloud9.ap-southeast-1.amazonaws.com/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at https://5e096a3bde6c49998d0b927346b58f57.vfs.cloud9.ap-southeast-1.amazonaws.com/rails/mailers/user_mailer/account_activation
  def account_activation
    user = User.first
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
  end

  # Preview this email at https://5e096a3bde6c49998d0b927346b58f57.vfs.cloud9.ap-southeast-1.amazonaws.com/rails/mailers/user_mailer/password_reset
  def password_reset
    user = User.first
    user.reset_token = User.new_token
    UserMailer.password_reset(user)
  end

end
