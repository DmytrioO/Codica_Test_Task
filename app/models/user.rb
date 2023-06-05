class User < ApplicationRecord
  include Constantable

  require 'aws-sdk-s3'

  devise :database_authenticatable, :registerable, :rememberable

  enum :role, %i[patient doctor], default: 0

  has_many :appointments_as_doctor, class_name: 'Appointment', foreign_key: :doctor_id, dependent: :destroy
  has_many :patients, through: :appointments_as_doctor, source: :patient

  has_many :appointments_as_patient, class_name: 'Appointment', foreign_key: :patient_id, dependent: :destroy
  has_many :doctors, through: :appointments_as_patient, source: :doctor

  belongs_to :category, optional: true

  validates :phone, uniqueness: true, presence: true, format: { with: PHONE_REGEX }
  validates :password, presence: true, length: { minimum: PASSWORD_MINIMUM_LENGTH }, format: { with: PASSWORD_REGEX },
                       unless: :skip_password_validation?
  validates :first_name, :last_name, presence: true, format: { with: NAME_REGEX }
  validates :second_name, format: { with: NAME_REGEX }, allow_blank: true
  validate :older_than_eighteen

  def skip_password_validation?
    photo_changed? && persisted? || password.blank?
  end

  def upload_image(image)
    s3 = Aws::S3::Resource.new(
      region: ENV['AWS_REGION'],
      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
    )
    bucket = s3.bucket(ENV.fetch('AWS_BUCKET_NAME', nil))

    object_key = "#{SecureRandom.hex}.#{File.extname(image.original_filename)}"

    obj = bucket.object(object_key)
    obj.put(body: image.tempfile, acl: 'public-read')

    update(photo: obj.public_url)
  end

  def full_name
    full_name = [first_name, last_name]
    full_name << second_name if second_name.present?
    full_name.join(' ')
  end

  private

  def older_than_eighteen
    return if birthday.blank?

    errors.add(:birthday, 'must be older than 18 years!') if birthday >= 18.years.ago.to_date
  end
end
