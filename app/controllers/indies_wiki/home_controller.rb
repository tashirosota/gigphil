class IndiesWiki::HomeController < ApplicationController
  skip_before_action :authenticate!
  def show
    @artist_hash = {
      name: 'Someday\'s gone',
      area: '宇都宮',
      tags: ['メロディー', 'ギターロック', 'パワーポップ'],
      icon: 'https://somedaysgone.com/assets/imgs/about/somedaysgone.jpg'
    }
  end
end
