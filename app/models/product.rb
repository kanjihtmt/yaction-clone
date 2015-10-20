class Product < ActiveRecord::Base
  enum status: %i(draft published unused)

  DRAFT = 0.freeze
  PUBLISHED = 1.freeze
  UNUSED = 2.freeze

  scope :status, ->(status) do
    status = status.to_i unless status.blank?
    # unless status.blank? は 空でないなら という否定の否定なので直感的に読みにくくなってしまうので
    # if status.present? にすると 存在するなら という形になって読みやすくなります。
    case (status)
      when PUBLISHED
        where("status = ? and start_date <= ? and end_date >= ?", PUBLISHED, Time.now, Time.now)
          .order(created_at: :desc)
      when UNUSED
        where("status = ? or end_date < ?", UNUSED, Time.now).order(created_at: :desc)
      else
        order(created_at: :desc)
    end
  end

  belongs_to :max_bidding, class_name: 'Bidding'
  belongs_to :seller, class_name: 'User'
  has_many :biddings, dependent: :destroy
  has_many :bidders, class_name: 'User', through: :biddings

  mount_uploader :image,  ImageUploader
  mount_uploader :image2, ImageUploader
  mount_uploader :image3, ImageUploader

  validates :name, :seller_id, :start_date, :end_date, presence: true
  validates :price, presence: true, numericality: {only: :integer, greater_than: 0}
  validates :image, presence: true

  def publishable?
    self.end_date > Time.now
  end
end
