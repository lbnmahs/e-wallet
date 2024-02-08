import 'package:card_manager/models/bank_card.dart';
import 'package:card_manager/widgets/usercard_details.dart';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class UserCards extends StatefulWidget {
  const UserCards({
    super.key, 
    required this.availableCards, 
    required this.onCardSwipe
  });

  final List<BankCard> availableCards;
  final Function(int) onCardSwipe;

  @override
  State<UserCards> createState() {
    return _UserCardsState();
  }
}

class _UserCardsState extends State<UserCards> {
  List<BankCard> userCards = [];
  final CardSwiperController controller = CardSwiperController();
  int currentCardIndex = 0;
  

  @override
  void initState() {
    super.initState();
    userCards = widget.availableCards;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 215,
      child: CardSwiper(
        cardBuilder: ((context, index, horizontalOffsetPercentage, verticalOffsetPercentage) {
          return Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [userCards[index].gradient[0], userCards[index].gradient[1]],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.7),
                width: 2
              ),
              borderRadius: BorderRadius.circular(16)
            ),
            child: UserCardDetails(cardInfo: userCards[index])
          );
        }), 
        backCardOffset: const Offset(0, -20),
        controller: controller,
        isLoop: true,
        numberOfCardsDisplayed: 3,
        cardsCount: userCards.length,
        onSwipe: (index, nextIndex, direction) {
          if(nextIndex != null) {
            setState(() {
              currentCardIndex = (currentCardIndex + 1) % widget.availableCards.length; 
            });
            widget.onCardSwipe(currentCardIndex);
          }
          return true;
        },
      ),
    );
  }
}
