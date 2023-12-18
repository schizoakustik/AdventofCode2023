with hands_with_strengths as
(select hand
    ,strength
    ,(select strength from CardStrength
        where card = substr(hand, 1, 1)
    ) as first_card_strength 
    ,(select strength from CardStrength
        where card = substr(hand, 2, 1)
    ) as second_card_strength 
    ,(select strength from CardStrength
        where card = substr(hand, 3, 1)
    ) as third_card_strength 
    ,(select strength from CardStrength
        where card = substr(hand, 4, 1)
    ) as fourth_card_strength 
    ,(select strength from CardStrength
        where card = substr(hand, 5, 1)
    ) as fifth_card_strength
    ,bet
from CamelCardHands)
,hands_with_ranks as
(select * 
    ,DENSE_RANK() OVER (
    ORDER BY 
        strength
        ,first_card_strength
        ,second_card_strength
        ,third_card_strength
        ,fourth_card_strength
        ,fifth_card_strength
    ) as rank
 from hands_with_strengths)

-- SELECT hand
--     ,rank
--     ,strength
--     ,bet
--     ,bet*rank as win
-- from hands_with_ranks
-- where strength = 7
-- order by rank desc;

SELECT sum(bet*rank) as total_win
from hands_with_ranks;