SELECT 
    betid,
    amount,
    amounteur,
    currency,
    endtime,
    gamecode,
    gamegroup,
    userid,
    wallettype,
    gamename,
    amounteur/amount AS eurexchangerate          
FROM mysql.BetActivity                     
WHERE  wallettype = 'RealCash' AND amount <> 0