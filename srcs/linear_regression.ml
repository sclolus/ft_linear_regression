(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   linear_regression.ml                               :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: sclolus <marvin@42.fr>                     +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2018/10/17 06:24:19 by sclolus           #+#    #+#             *)
(*   Updated: 2018/10/17 09:09:49 by sclolus          ###   ########.fr       *)
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
                                       
let train_on_dataset dataset learning_rate =
  let data_length = List.length dataset in
  let rec aux theta0 theta1 current_size =
    if current_size > data_length
    then (theta0, theta1)
    else
      begin
        let prefix_factors = learning_rate *. (1.0 /. float_of_int data_length) in
        let folding_closure = (fun acc (mileage, price) -> acc +. ((guess_target mileage theta0 theta1) -. price)) in
        let tmp_theta0 = (prefix_factors *. List.fold_left folding_closure 0.0 dataset) in
        let folding_closure = (fun acc (mileage, price) -> acc +. (((guess_target mileage theta0 theta1) -. price) *. mileage)) in
        let tmp_theta1 = (prefix_factors *. List.fold_left folding_closure 0.0 dataset) in
        Printf.printf "t0 = %f, t1 = %f\n" tmp_theta0 tmp_theta1 ;
        (* let (mileage, price) = List.nth dataset (current_size - 1) in
         * let tmp_theta0 = theta0 -. (prefix_factors *. ((guess_target mileage theta0 theta1) -. price)) in
         * let tmp_theta1 = theta1 -. (prefix_factors *. (((guess_target mileage theta0 theta1) -. price) *. mileage)) in *)
        aux tmp_theta0 tmp_theta1 (current_size + 1)
      end
  in
  aux 0.0 0.0 1    
