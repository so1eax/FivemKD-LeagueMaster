CREATE TABLE `kdsys_users` (
  `identifier` char(255) NOT NULL,
  `username` char(255) NOT NULL,
  `kills` int(10) NOT NULL,
  `deaths` int(10) NOT NULL,
  `id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `kdsys_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `identifier` (`identifier`);

ALTER TABLE `kdsys_users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=0;
COMMIT;