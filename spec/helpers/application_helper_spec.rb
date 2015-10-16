require 'rails_helper'

describe ApplicationHelper do
  describe '#get_title_of_products' do
    it "ステータスに該当するページタイトできること" do
      expect(get_title_of_products(Product::PUBLISHED)).to eq '出品中の商品一覧'
      expect(get_title_of_products(Product::UNUSED)).to eq '出品終了分の商品一覧'
      expect(get_title_of_products(Product::DRAFT)).to eq '商品一覧'
    end
  end

  describe '#interval' do
    [:year, :month, :day].each do |unit|
      it "開始 < 終了の場合は1以上の整数が返ること" do
        from = Time.local(2010, 5, 5, 6, 30)
        to = Time.local(2015, 10, 10, 6, 30)
        expect(interval(unit, from, to)).to eq 5
      end

      it "開始 = 終了の場合は0が返ること" do
        from = Time.local(2015, 5, 5, 6, 30)
        to = Time.local(2015, 5, 5, 6, 30)
        expect(interval(unit, from, to)).to eq 0
      end

      it "開始 > 終了の場合は0が返ること" do
        from = Time.local(2016,11, 11, 6, 30)
        to = Time.local(2015, 10, 10, 12, 05)
        expect(interval(unit, from, to)).to eq 0
      end
    end
  end

  describe '#expiration?' do
    it '現在日 < 終了日であれば有効期間であること' do
      Timecop.travel(2015, 10, 17, 10, 30)
      expect(expiration?(Time.local(2015, 10, 18, 10, 30))).to be_truthy
    end

    it '現在日 = 終了日であれば期限切れとして扱われること' do
      Timecop.travel(2015, 10, 18, 10, 30)
      expect(expiration?(Time.local(2015, 10, 18, 10, 30))).to be_falsey
    end

    it '現在日 > 終了日であれば期限切れとして扱われること' do
      Timecop.travel(2015, 10, 19, 10, 30)
      expect(expiration?(Time.local(2015, 10, 18, 10, 30))).to be_falsey
    end
  end

  describe '#judged?' do
  end
end