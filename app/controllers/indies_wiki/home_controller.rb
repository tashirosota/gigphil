class IndiesWiki::HomeController < ApplicationController
  skip_before_action :authenticate!
  def show
    @artists = []
    @artists << {
      name: 'Someday\'s gone',
      area: '宇都宮',
      tags: ['メロディー', 'ギターロック', 'パワーポップ'],
      icon: 'http://kotori-band.com/img/_member/011.jpg'
    }
    @artists << {
      name: 'KOTORI',
      area: '宇都宮',
      tags: ['メロディー', 'ギターロック', 'パワーポップ'],
      icon: 'https://somedaysgone.com/assets/imgs/about/somedaysgone.jpg'
    }
    @artists << {
      name: 'SonoSheet',
      area: '宇都宮',
      tags: ['反省', 'メロコア', 'パワーポップ'],
      icon: 'https://66.media.tumblr.com/d44fc715131afeddaa139b7aa751c314/tumblr_inline_pk1i2dLF4P1tk8unz_500.jpg'
    }
    @artists << {
      name: 'soshaku',
      area: 'せんかわ',
      tags: ['おじさん', 'おさけ', 'パワーポップ'],
      icon: 'http://soshaku.wp.xdomain.jp/wp-content/themes/soshaku/img/profile.jpg'
    }
    @artists << {
      name: 'FANCY GIRL CINEMA',
      area: '大塚',
      tags: ['パワーポップ', 'Oasis', 'パワーポップ'],
      icon: 'https://static.wixstatic.com/media/28e8f4_ff1d23368e6841c99397a8e75f1f9040~mv2.jpg/v1/fill/w_1544,h_931,al_c,q_85/21469.webp'
    }

    @artists << {
      name: 'fish in water project',
      area: '高崎',
      tags: ['おしゃれさん', '電子音', 'シュッとしてる'],
      icon: 'https://static.wixstatic.com/media/6c06b5_1ab8fe87a43143df915ee18213cdf864~mv2.jpg/v1/fill/w_512,h_404,al_c,q_80,usm_0.66_1.00_0.01/IMG_1435_JPG.webp'
    }

  end
end
