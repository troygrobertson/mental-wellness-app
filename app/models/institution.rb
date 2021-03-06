class Institution < ActiveRecord::Base
    has_many :institution_memberships
	has_many :pools, :through => :institution_memberships,:source => :memberable,:source_type => "Pool"
	has_many :users, :through => :institution_memberships,:source => :memberable,:source_type => "User"
    has_many :messages, :as => :messageable
    accepts_nested_attributes_for :pools
	validates_presence_of :name, :description

end
