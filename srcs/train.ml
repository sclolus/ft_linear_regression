(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   train.ml                                           :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: sclolus <marvin@42.fr>                     +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2018/10/17 05:50:22 by sclolus           #+#    #+#             *)
(*   Updated: 2018/10/25 01:21:03 by sclolus          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)


let usage: string = "./train data_set_filename"
let exit_failure = 1
let exit_success = 0
                  
let print_usage () =
  prerr_endline usage

let open_dataset_file filename =
  let in_channel = try Some (open_in filename) with
                   | Sys_error (err_string) -> begin
                       prerr_endline err_string ;
                       None
                     end
                   | _ ->
                      begin
                       prerr_endline "Unexpected error" ;
                       None
                      end in
  in_channel
  
                        
  
let () =
  let argv = Sys.argv in
  if Array.length argv <> 2
  then
    begin
      print_usage () ;
      exit exit_failure
    end
  else
    let filename = argv.(1) in
    let in_channel = match (open_dataset_file filename) with
      | Some channel -> channel
      | None -> exit exit_failure
    in
    let dataset = Parsing.parse_dataset in_channel in
    Dataset.print_dataset dataset ;
    print_endline "Now training on dataset" ;
    let (t0, t1) = Linear_regression.train_on_dataset dataset 0.0000000001501  in
    Printf.printf "Finished training: t0 = %f, t1 = %f\n" t0 t1 ;
    List.iter (fun (mileage, price) -> let prediction = (Linear_regression.guess_target mileage t0 t1) in
                                       Printf.printf "guess on %f:%f -> %f\n" mileage price prediction) ((* Linear_regression.normalize_dataset  *)dataset)
    ;
      Graphics.open_graph " 1920x1080";
    let features = List.sort (fun a b -> compare a b) (List.map (fun (feature, _) -> feature) dataset) in
    let results = List.sort (fun a b -> compare a b) (List.map (fun (_, result) -> result) dataset) in
    let min_x = List.hd results in
    let min_y = List.hd features in
    let max_x = List.nth results (List.length results - 1) in
    let max_y = List.nth features (List.length features - 1) in
    Printf.printf "t0: %f, t1: %f\n" t0 t1 ;
    print_endline "GRAPHING" ;
    Graph.draw_linear_function t0 t1 min_x max_x min_y max_y ;
    Graph.draw_dataset (* (List.map (fun (x, y) -> (y, x)) dataset)  *) dataset;
    flush_all ();
    let rec loop () =
      loop () in
    loop ()
    
        
