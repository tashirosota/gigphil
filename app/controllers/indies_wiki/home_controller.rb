class IndiesWiki::HomeController < ApplicationController
  skip_before_action :authenticate!
  def show
    tags = Tag.all.map(&:name)
    areas = Area.all.map(&:name)
    artists = RegisteredArtist.all
    @artists = []
    @artists << {
      id: artists.sample.id,
      name: artists.sample.name,
      area: areas.sample,
      tags: %w(メロディー ギターロック パワーポップ),
      icon: 'http://soshaku.wp.xdomain.jp/wp-content/themes/soshaku/img/profile.jpg'
    }
    @artists << {
      id: artists.sample.id,
      name: artists.sample.name,
      area: areas.sample,
      tags: tags.shuffle.take(3),
      icon: 'https://somedaysgone.com/assets/imgs/about/somedaysgone.jpg'
    }
    @artists << {
      id: artists.sample.id,
      name: artists.sample.name,
      area: areas.sample,
      tags: tags.shuffle.take(3),
      icon: 'https://66.media.tumblr.com/d44fc715131afeddaa139b7aa751c314/tumblr_inline_pk1i2dLF4P1tk8unz_500.jpg'
    }
    @artists << {
      id: artists.sample.id,
      name: artists.sample.name,
      area: areas.sample,
      tags: tags.shuffle.take(3),
      icon: 'http://soshaku.wp.xdomain.jp/wp-content/themes/soshaku/img/profile.jpg'
    }
    @artists << {
      id: artists.sample.id,
      name: artists.sample.name,
      area: areas.sample,
      tags: tags.shuffle.take(3),
      icon: 'https://static.wixstatic.com/media/28e8f4_ff1d23368e6841c99397a8e75f1f9040~mv2.jpg/v1/fill/w_1544,h_931,al_c,q_85/21469.webp'
    }
    @artists << {
      id: artists.sample.id,
      name: artists.sample.name,
      area: areas.sample,
      tags:  tags.shuffle.take(3),
      icon: 'https://66.media.tumblr.com/d44fc715131afeddaa139b7aa751c314/tumblr_inline_pk1i2dLF4P1tk8unz_500.jpg'
    }
    @artists << {
      id: artists.sample.id,
      name: artists.sample.name,
      area: areas.sample,
      tags:  tags.shuffle.take(3),
      icon: 'http://soshaku.wp.xdomain.jp/wp-content/themes/soshaku/img/profile.jpg'
    }
    @artists << {
      id: artists.sample.id,
      name: artists.sample.name,
      area: areas.sample,
      tags:  tags.shuffle.take(3),
      icon: 'https://static.wixstatic.com/media/28e8f4_ff1d23368e6841c99397a8e75f1f9040~mv2.jpg/v1/fill/w_1544,h_931,al_c,q_85/21469.webp'
    }

    @artists << {
      id: artists.sample.id,
      name: artists.sample.name,
      area: areas.sample,
      tags:  tags.shuffle.take(3),
      icon: 'https://static.wixstatic.com/media/6c06b5_1ab8fe87a43143df915ee18213cdf864~mv2.jpg/v1/fill/w_512,h_404,al_c,q_80,usm_0.66_1.00_0.01/IMG_1435_JPG.webp'
    }

    @tags = Tag.all.map(&:name)
    @areas = Area.all.map(&:name)
  end
end
