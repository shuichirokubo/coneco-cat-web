require_relative '../../app/models/rakuten_cat.rb'
require 'net/http'
require 'uri'
require 'json'

# constant variable
AFFILIATEID = '0e2a74f8.b705f347.0e2a74f9.ce1173da'
APPLICATIONID = 'bfc5bca21a7bac85a197a29ebeab80dd'

class Tasks::FetchRakutenCats
  def self.execute
    search_word_array = ['猫 ぬいぐるみ', '猫 雑貨', '猫 キーホルダー', '猫 インテリア', 'ねこ ぬいぐるみ']
    sort_array = %w(-reviewAverage -reviewCount -itemPrice +itemPrice -updateTimestamp standard)
    #rakutenUrl += '&keyword=' + encodeURIComponent(searchWord);
    #rakutenUrl += '&sort=' + encodeURIComponent(shuffle_array(sortArray)[0]);
    search_word_array.each do |search_word|
      sort_array.each do |sort_word|
        rakuten_uri = URI.parse(URI.escape(%Q(https://app.rakuten.co.jp/services/api/IchibaItem/Search/20140222?format=json&affiliateId=#{AFFILIATEID}&applicationId=#{APPLICATIONID}&keyword=#{search_word}&sort=#{sort_word})))
        res = Net::HTTP.get_response(rakuten_uri)
        results = JSON.parse(res.body)
        if results['Items'].present?
          results['Items'].each do |item|
            RakutenCat.find_or_create_by(code: item['Item']['itemCode']) do |rakuten_cat|
              rakuten_cat.code           = item['Item']['itemCode']
              rakuten_cat.name           = item['Item']['itemName']
              rakuten_cat.price          = item['Item']['itemPrice']
              rakuten_cat.afl_url        = item['Item']['affiliateUrl']
              rakuten_cat.image_url      = item['Item']['mediumImageUrls'][0]['imageUrl']
              rakuten_cat.catchcopy      = item['Item']['catchcopy']
              rakuten_cat.caption        = ''
              rakuten_cat.review_average = item['Item']['reviewAverage']
              rakuten_cat.review_count   = item['Item']['reviewCount']
              rakuten_cat.save!
            end
          end
        end
      end
    end
  end
end

__END__

bundle exec rails runner Tasks::FetchRakutenCats.execute

mysql> desc rakuten_cats;
+----------------+--------------+------+-----+---------+----------------+
| Field          | Type         | Null | Key | Default | Extra          |
+----------------+--------------+------+-----+---------+----------------+
| id             | int(11)      | NO   | PRI | NULL    | auto_increment |
| code           | varchar(255) | YES  | UNI | NULL    |                |
| name           | varchar(255) | YES  |     | NULL    |                |
| price          | int(11)      | YES  |     | NULL    |                |
| afl_url        | varchar(255) | YES  |     | NULL    |                |
| image_url      | varchar(255) | YES  |     | NULL    |                |
| catchcopy      | varchar(255) | YES  |     | NULL    |                |
| caption        | varchar(255) | YES  |     | NULL    |                |
| review_average | int(11)      | YES  |     | NULL    |                |
| review_count   | int(11)      | YES  |     | NULL    |                |
| created_at     | datetime     | NO   |     | NULL    |                |
| updated_at     | datetime     | NO   |     | NULL    |                |
+----------------+--------------+------+-----+---------+----------------+
12 rows in set (0.00 sec)
