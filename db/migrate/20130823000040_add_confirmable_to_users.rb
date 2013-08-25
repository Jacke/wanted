class AddConfirmableToUsers < ActiveRecord::Migration
def self.up
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # users as confirmed, do the following
    User.update_all(:confirmed_at => Time.now)
    # All existing user accounts should be able to log in after this.
  end

  def self.down
    remove_column :users, :confirmation_token, :confirmed_at, :confirmation_sent_at
    # remove_column :users, :unconfirmed_email # Only if using reconfirmable
  end
end