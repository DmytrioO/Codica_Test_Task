class User < ApplicationRecord
  require 'aws-sdk-s3'

  devise :database_authenticatable, :registerable, :rememberable

  PHONE_REGEX = /\A\+\d{12}\z/
  PASSWORD_MINIMUM_LENGTH = 6
  NAME_REGEX = /\A[a-zA-Z]+\z/
  PASSWORD_REGEX = /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)/

  enum :role, %i[patient doctor admin], default: 0

  validates :phone, uniqueness: true, presence: true,  format: { with: PHONE_REGEX }
  validates :password, presence: true, length: { minimum: PASSWORD_MINIMUM_LENGTH }, format: { with: PASSWORD_REGEX }, 
                       unless: :updating_photo?
  validates :first_name, :last_name, presence: true, format: { with: NAME_REGEX }
  validates :second_name, format: { with: NAME_REGEX }, allow_blank: true
  validates :birthday, presence: true
  validate :older_than_eighteen

  def updating_photo?
    photo_changed? && persisted?
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

    update!(photo: obj.public_url)
  end

  private

  def older_than_eighteen
    errors.add(:birthday, 'must be older than 18 years!') if birthday >= 18.years.ago.to_date
  end
end
