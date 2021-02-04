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
FROM mysql.WinActivity                     
WHERE  wallettype = 'RealCash' AND amount <> 0