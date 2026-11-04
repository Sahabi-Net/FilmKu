import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../models/movie_item.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final CardSwiperController swiperController = CardSwiperController();
  final CarouselSliderController _carouselController = CarouselSliderController();

  int _currentCarouselIndex = 0;

  final List<String> bannerList = [
    'assets/images/demonslayer.jpg',
    'assets/images/onepiece.jpg',
    'assets/images/solo.jpg',
  ];

  final List<MovieItem> movieList = [
    MovieItem(
      rank: 1,
      title: 'Demon Slayer: Kimetsu no Yaiba – The Movie: Infinity Castle',
      imagePath: 'assets/images/top_demon.jpg',
    ),
    MovieItem(
      rank: 2,
      title: 'Chainsaw Man – The Movie: Reze Arc',
      imagePath: 'assets/images/top_chainsawman.webp',
    ),
    MovieItem(
      rank: 3,
      title: 'Gintama the Movie: Yoshiwara in Flames',
      imagePath: 'assets/images/top_gintama.jpg',
    ),
    MovieItem(
      rank: 4,
      title: 'Detective Conan: Fallen Angel of the Highway',
      imagePath: 'assets/images/top_detective.jpg',
    ),
  ];

  final List<Widget> cards = [
    _buildFeaturedCard(
      title: 'PROMO BUY 1 GET 1',
      subtitle: 'Khusus pengguna kartu kredit BCA/Mandiri',
      badge: 'PROMO SPECIAL',
      icon: Icons.local_activity,
      color: const Color(0xFFE50914),
    ),
    _buildFeaturedCard(
      title: 'VELVET CLASS',
      subtitle: 'Nikmati menonton bioskop dengan bed premium',
      badge: 'LUXURY EXPERIENCE',
      icon: Icons.king_bed,
      color: Colors.amber.shade700,
    ),
    _buildFeaturedCard(
      title: 'FilmKu MERCHANDISE',
      subtitle: 'Dapatkan Popcorn Bucket edisi terbatas Demon Slayer',
      badge: 'LIMITED EDITION',
      icon: Icons.shopping_bag,
      color: Colors.purpleAccent,
    ),
  ];

  static Widget _buildFeaturedCard({
    required String title,
    required String subtitle,
    required String badge,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              badge,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Icon(icon, size: 56, color: color),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'FilmKu',
          style: TextStyle(
            fontFamily: 'sans-serif-condensed',
            color: Color(0xFFE50914),
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER BANNER ---
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: Row(
                children: [
                  Icon(Icons.local_offer, color: Color(0xFFE50914), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'COMING SOON IN 2027',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),

            // --- 1. BANNER CAROUSEL SLIDER ---
            CarouselSlider(
              carouselController: _carouselController,
              items: bannerList
                  .map((item) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                item,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: Colors.grey[850],
                                  child: const Icon(Icons.broken_image, color: Colors.white38),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.transparent, Colors.black87],
                                    begin: Alignment.center,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                aspectRatio: 2.0,
                viewportFraction: 0.92,
                autoPlay: true,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentCarouselIndex = index;
                  });
                },
              ),
            ),

            const SizedBox(height: 8),

            // --- CUSTOM INDICATOR ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: bannerList.asMap().entries.map((entry) {
                final bool isActive = _currentCarouselIndex == entry.key;
                return GestureDetector(
                  onTap: () => _carouselController.animateToPage(entry.key),
                  child: Container(
                    width: isActive ? 22.0 : 8.0,
                    height: 4.0,
                    margin: const EdgeInsets.symmetric(horizontal: 3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: isActive ? const Color(0xFFE50914) : Colors.white24,
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // --- HEADER POSTER TOP MOVIES ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(Icons.star, color: Color(0xFFE50914), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'TOP MOVIES',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // --- 2. LIST POSTER HORIZONTAL ---
            SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: movieList.length,
                itemBuilder: (context, index) {
                  final movie = movieList[index];
                  return Container(
                    width: 140,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                movie.imagePath,
                                height: 200,
                                width: 140,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 200,
                                  width: 140,
                                  color: Colors.grey[800],
                                  child: const Icon(Icons.movie, color: Colors.white54),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE50914),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  '${movie.rank}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          movie.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // --- HEADER FEATURED SELECTIONS ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.movie_filter, color: Color(0xFFE50914), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'FEATURED SELECTIONS',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // --- 3. CARD SWIPER ---
            Center(
              child: SizedBox(
                height: 340,
                width: MediaQuery.of(context).size.width * 0.85,
                child: CardSwiper(
                  controller: swiperController,
                  cardsCount: cards.length,
                  cardBuilder: (context, index, percentX, percentY) {
                    return cards[index];
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}