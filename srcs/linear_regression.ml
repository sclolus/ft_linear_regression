(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   linear_regression.ml                               :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: sclolus <marvin@42.fr>                     +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2018/10/17 06:24:19 by sclolus           #+#    #+#             *)
(*   Updated: 2018/10/25 03:17:41 by sclolus          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let guess_target feature theta0 theta1 = theta0 +. (theta1 *. feature)

let take lst size =
  let rec aux lst size acc =
    if size = 0
    then acc
    else
      match lst with
      | head :: tail -> aux tail (size - 1) (head :: acc)
      | [] -> failwith "Not enough elements in list"
  in
  assert (size > 0) ;
  List.rev (aux lst size [])
  
let min lst = List.hd (List.sort (compare) lst)
let max lst = List.hd (List.sort (fun a b -> (compare b a)) lst)

let normalize_dataset dataset =
  let aux data results fmin fmax =
    List.map (fun (feature, result) -> ((feature -. fmin) /. (fmax -. fmin), result)) data
  in
  let feature_min = min (List.map (fun (feature, _) -> feature) dataset) in
  let feature_max = max (List.map (fun (feature, _) -> feature) dataset) in
  let results = List.map (fun (_, result) -> result) dataset in
  (aux dataset results feature_min feature_max)
  
let train_on_dataset dataset learning_rate =
  let data_length = List.length dataset in
  let prefix_average_factor = (1.0 /. (float_of_int data_length)) in
  let dataset = normalize_dataset dataset in
  let rec aux theta0 theta1 current_size =
    if current_size > data_length * data_length * data_length * data_length
    then (theta0, theta1)
    else
      begin
        let error_closure = (fun (feature, result) -> guess_target feature theta0 theta1 -. result) in
        let error_squared_closure = (fun (feature, result) -> (error_closure (feature, result)) ** 2.0) in
        let error_sum = (fun acc (feature, result) -> acc +. error_closure (feature, result)) in
        let theta1_derivative_sum = (fun acc (feature, result) -> acc +. (error_closure (feature, result)) *. feature) in
        let theta0_derivative = learning_rate *. prefix_average_factor *. List.fold_left error_sum 0.0 dataset in
        let theta1_derivative = learning_rate *. prefix_average_factor *. List.fold_left theta1_derivative_sum 0.0 dataset in
        let new_theta0 = theta0 -. theta0_derivative in
        let new_theta1 = theta1 -. theta1_derivative in
        aux new_theta0 new_theta1 (current_size + 1)
      end
  in
  Dataset.print_dataset dataset ;
  aux 0.0 0.0 0
