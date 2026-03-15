#!/usr/bin/env php
<?php

   $format   = isset($argv[1]) ? $argv[1] : "txt";  #txt #html #csv
   $username = isset($argv[2]) ? $argv[2] : "";     #domas

   #koks inputas del user
   if ($username != "") {
      $processes = shell_exec("tasklist /FO CSV /V /FI \"USERNAME eq $username\"");
      
   }
   else {
      $processes = shell_exec("tasklist /FO CSV /V");
   }


   #procesai sudedami i array
   $data = [];
   $header = [];
   $lines = explode("\n", $processes);

   foreach ($lines as $line) {
      $row = str_getcsv($line, ",", '"', "");

      if (empty($header)) {
         $header = $row;
      }
      else {
         $data[] = $row;
      }
   }

   #koks inputas format
   if ($format == "csv") {
      $file = fopen("5_log.csv", "w");
      fputcsv($file, $header, ",", '"', "");
      foreach($data as $row) {
         fputcsv($file, $row, ",", '"', "");
      }
      fclose($file);
   }
   elseif ($format == "html"){
      $html = "<html><body>\n";
      $html .= "<table border='1'>\n";
      
      $html .= "<thead><tr>\n";
      foreach ($header as $st) {
         $html .= "<th>\n" . htmlspecialchars($st) . "</th>\n";
      }
      $html .= "</tr></thead>\n";
      
      $html .= "<tbody>\n";
      foreach ($data as $row) {
         $html .= "<tr>\n";
         foreach ($row as $cell) {
               $html .= "<td>\n" . htmlspecialchars($cell ?? "") . "</td>\n";
         }
         $html .= "</tr>\n";
      }
      $html .= "</tbody>\n";
      $html .= "</table></body></html>\n";
      file_put_contents("5_log.html", $html);
   }
   else {

      $txt = "";
      $txt .= implode("\t", $header) . "\n";
      foreach ($data as $row) {
         $txt .= implode("\t", $row) . "\n";
      }
      file_put_contents("5_log.txt", $txt);
   }

   readline("Press Enter to exit...");
   unlink("5_log." . $format);


?>