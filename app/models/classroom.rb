# == Schema Information
#
# Table name: classrooms
#
#  id      :bigint           not null, primary key
#  name    :string           not null
#  user_id :bigint
#
# Indexes
#
#  index_classrooms_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#


class Classroom < ApplicationRecord
end