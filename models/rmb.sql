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
    amounteur/amount AS eurexchangerate          
FROM mysql.BetActivity                     
WHERE  wallettype = 'RealCash' AND amount <> 0