--Wipe Non Developed Upgradeables 1.298
--(Wipes 2880 Item Total)
--Can_SnoxD
--
USE KN_online
--
--Daggers
DELETE FROM ITEM WHERE DexB BETWEEN 2 AND 18 and ItemType = '5' and kind like '11'
DELETE FROM ITEM WHERE FireR BETWEEN 3 AND 27 and ItemType = '5' and kind like '11'
--Axe
DELETE FROM ITEM WHERE StrB BETWEEN 2 AND 18 and ItemType = '5' and kind like '31'
DELETE FROM ITEM WHERE ColdR BETWEEN 3 AND 27 and ItemType = '5' and kind like '31'
--X Mace
DELETE FROM ITEM WHERE StaB BETWEEN 2 AND 18 and ItemType = '5' and kind like '42'
DELETE FROM ITEM WHERE ColdR BETWEEN 3 AND 27 and ItemType = '5' and kind like '42'
--Spear
DELETE FROM ITEM WHERE DexB BETWEEN 2 AND 18 and ItemType = '5' and kind like '51'
DELETE FROM ITEM WHERE LightningR BETWEEN 3 AND 27 and ItemType = '5' and kind like '51'
--X Axe
DELETE FROM ITEM WHERE StrB BETWEEN 2 AND 18 and ItemType = '5' and kind like '32'
DELETE FROM ITEM WHERE ColdR BETWEEN 3 AND 27 and ItemType = '5' and kind like '32'
--Swords
DELETE FROM ITEM WHERE StrB BETWEEN 2 AND 18 and ItemType = '5' and kind like '21'
DELETE FROM ITEM WHERE FireR BETWEEN 3 AND 27 and ItemType = '5' and kind like '21'
--X Swords
DELETE FROM ITEM WHERE StrB BETWEEN 2 AND 18 and ItemType = '5' and kind like '22'
DELETE FROM ITEM WHERE FireR BETWEEN 3 AND 27 and ItemType = '5' and kind like '22'
--Mace
DELETE FROM ITEM WHERE StaB BETWEEN 2 AND 18 and ItemType = '5' and kind like '41'
DELETE FROM ITEM WHERE ColdR BETWEEN 3 AND 27 and ItemType = '5' and kind like '41'
--X Spear
DELETE FROM ITEM WHERE StrB BETWEEN 2 AND 18 and ItemType = '5' and kind like '52'
DELETE FROM ITEM WHERE LightningR BETWEEN 3 AND 27 and ItemType = '5' and kind like '52'
--Bow
DELETE FROM ITEM WHERE DexB BETWEEN 2 AND 18 and ItemType = '5' and kind like '70'
DELETE FROM ITEM WHERE MagicR BETWEEN 3 AND 27 and ItemType = '5' and kind like '70'
--Staff
DELETE FROM ITEM WHERE ChaB BETWEEN 2 AND 18 and ItemType = '5' and kind like '110'
DELETE FROM ITEM WHERE MagicR BETWEEN 3 AND 27 and ItemType = '5' and kind like '110'
--X Bow
DELETE FROM ITEM WHERE DexB BETWEEN 2 AND 18 and ItemType = '5' and kind like '71'
DELETE FROM ITEM WHERE MagicR BETWEEN 3 AND 27 and ItemType = '5' and kind like '71'