class CreateDatabase < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.belongs_to :group, index: true, foreign_key: true, optional: true
      t.string :name
      t.string :description

      t.timestamps
    end

    create_table :locations do |t|
      t.belongs_to :group, index: true, foreign_key: true
      t.string :name
      t.string :address
      t.string :description

      t.timestamps
    end

    create_table :sublocations do |t|
      t.belongs_to :location, index: true, foreign_key: true, optional: true
      t.belongs_to :sublocation, index: true, foreign_key: true, optional: true
      t.string :name
      t.string :description

      t.timestamps
    end

    create_table :stock_items do |t|
      t.belongs_to :sublocation, index: true, foreign_key: true
      t.string :name
      t.string :description
      t.integer :required
      t.integer :order_to

      t.timestamps
    end

    create_table :items do |t|
      t.belongs_to :stock_item, index: true, foreign_key: true
      t.datetime :expires
      t.integer :count

      t.timestamps
    end

    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: "", index: true
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token, index: true
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      # Uncomment below if timestamps were not included in your original model.
      t.timestamps null: false
    end

    create_table :audits, :force => true do |t|
      t.column :auditable_id, :integer
      t.column :auditable_type, :string
      t.column :associated_id, :integer
      t.column :associated_type, :string
      t.column :user_id, :integer
      t.column :user_type, :string
      t.column :username, :string
      t.column :action, :string
      t.column :audited_changes, :text
      t.column :version, :integer, :default => 0
      t.column :comment, :string
      t.column :remote_address, :string
      t.column :request_uuid, :string, index: true
      t.column :created_at, :datetime, index: true
    end

    add_index :audits, [:auditable_id, :auditable_type], :name => 'auditable_index'
    add_index :audits, [:associated_id, :associated_type], :name => 'associated_index'
    add_index :audits, [:user_id, :user_type], :name => 'user_index'
  end
end
