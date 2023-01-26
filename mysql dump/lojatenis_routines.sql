-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: lojatenis
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `info_vendas_formatado`
--

DROP TABLE IF EXISTS `info_vendas_formatado`;
/*!50001 DROP VIEW IF EXISTS `info_vendas_formatado`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `info_vendas_formatado` AS SELECT 
 1 AS `sneaker_nome`,
 1 AS `cliente_nome`,
 1 AS `quantidade`,
 1 AS `preco`,
 1 AS `data_venda`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `sneaker_infos`
--

DROP TABLE IF EXISTS `sneaker_infos`;
/*!50001 DROP VIEW IF EXISTS `sneaker_infos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sneaker_infos` AS SELECT 
 1 AS `model`,
 1 AS `marca`,
 1 AS `data_lancamento`,
 1 AS `nome`,
 1 AS `preco`,
 1 AS `tamanhos`,
 1 AS `img`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `info_vendas_formatado`
--

/*!50001 DROP VIEW IF EXISTS `info_vendas_formatado`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `info_vendas_formatado` AS select `sneakers`.`nome` AS `sneaker_nome`,`utilizadores`.`nome` AS `cliente_nome`,`vendas`.`quantidade` AS `quantidade`,`vendas`.`preco` AS `preco`,`vendas`.`data_venda` AS `data_venda` from ((`vendas` join `utilizadores` on((`vendas`.`utilizador_id` = `utilizadores`.`id`))) join `sneakers` on((`vendas`.`sneaker_id` = `sneakers`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sneaker_infos`
--

/*!50001 DROP VIEW IF EXISTS `sneaker_infos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sneaker_infos` AS select `sneaker_modelos`.`model` AS `model`,`sneaker_modelos`.`marca` AS `marca`,`sneaker_modelos`.`data_lancamento` AS `data_lancamento`,`sneakers`.`nome` AS `nome`,`sneakers`.`preco` AS `preco`,`sneakers`.`tamanhos` AS `tamanhos`,`sneakers`.`img` AS `img` from (`sneaker_modelos` join `sneakers` on((`sneaker_modelos`.`id` = `sneakers`.`model_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-01-26 22:14:14
