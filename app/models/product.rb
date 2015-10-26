class Product < ActiveRecord::Base
  enum status: %i(draft published unused)

  DRAFT = 0.freeze
  PUBLISHED = 1.freeze
  UNUSED = 2.freeze

  scope :status, ->(status) do
    status = status.to_i if status.present?
    case (status)
      when PUBLISHED
        where("status = ? and start_date <= ? and end_date >= ?", PUBLISHED, Time.now, Time.now)
          .order(created_at: :desc)
      when UNUSED
        where("status = ? or end_date < ?", UNUSED, Time.now).order(created_at: :desc)
        # Railsでは 現在の時刻は Time.current を使ったほうが行儀が良いです。
        # 参考URL 伊藤さんの qiita記事 http://qiita.com/jnchito/items/cae89ee43c30f5d6fa2c
      else
        order(created_at: :desc)
    end
  end

  # このスコープだと、 enumsに用意されている Product.published と Product.status( Product::PUBLISHED ) とで何が違うのか分かりにくい
  # しかも、 Product.status( Product::PUBLISHED ) だと status だけでなく有効な時間かどうかも条件式に入ってしまっていて、それがスコープ名から読み取れない
  # こういう英語で合っているのかは微妙ですが、bid可能なという意味の biddable というスコープを作って
  # scope :biddable, -> { published.where("start_date <= ? and end_date >= ?", Time.current, Time.current).order(created_at: :desc) }
  # とすることで、Product.biddable で bidできる物を取得しようとしていることがわかりやすくなります。
  # UNUSED のほうも Product.expired 等にしたほうが理解しやすいかもしれません。
  # 仕様が変わるので mypage で使う所も変更が必要ですが。

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
