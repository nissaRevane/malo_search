require 'json'

file_path = Rails.root.join('db/articles_simplified.json')
file = File.read(file_path)
data = JSON.parse(file)

Article.destroy_all
Tag.destroy_all

tag_cache = {}

data['posts'].each do |post|
  article = Article.create!(
    uuid: post['uuid'],
    title: post['title'],
    slug: post['slug'],
    excerpt: post['excerpt'],
    feature_image: post['feature_image'],
    published_at: post['published_at']
  )

  post['tags'].each do |tag_data|
    next if tag_data['name'].start_with?('#')

    tag = tag_cache[tag_data['slug']] ||= Tag.find_or_create_by!(
      name: tag_data['name'],
      slug: tag_data['slug']
    )

    article.tags << tag
  end
end

puts "✅ Seeded #{Article.count} articles and #{Tag.count} tags!"
