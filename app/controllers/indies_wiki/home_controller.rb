class IndiesWiki::HomeController < ApplicationController
  skip_before_action :authenticate!
  def show
    @artist_hash = {
      name: 'Someday\'s gone',
      area: '宇都宮',
      tags: ['メロディー', 'ギターロック', 'パワーポップ'],
      icon: 'http://kotori-band.com/img/_member/011.jpg'
    }
  end
end
