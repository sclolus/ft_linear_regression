(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   linear_regression.ml                               :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: sclolus <marvin@42.fr>                     +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2018/10/17 06:24:19 by sclolus           #+#    #+#             *)
(*   Updated: 2018/10/19 03:00:09 by sclolus          ###   ########.fr       *)
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
  let prefix_average_factor = (1.0 /. (float_of_int data_length)) in
  let rec aux theta0 theta1 current_size =
    if current_size > (* data_length * data_length * data_length *) 100000
    then (theta0, theta1)
    else
      begin
        let error_closure = (fun (feature, result) -> guess_target feature theta0 theta1 -. result) in
        let error_squared_closure = (fun (feature, result) -> (error_closure (feature, result)) ** 2.0) in
        Printf.printf "actual residual error squared: %f -< %f\n" (List.fold_left (fun acc (feature, result) -> acc +. error_squared_closure (feature, result)) 0.0 dataset)
        (List.fold_left (fun acc (feature, result) -> acc +. error_closure (feature, result)) 0.0 dataset);
        let error_sum = (fun acc (feature, result) -> acc +. error_closure (feature, result)) in
        let theta1_derivative_sum = (fun acc (feature, result) -> acc +. (error_closure (feature, result)) *. feature) in
        let theta0_derivative = learning_rate *. prefix_average_factor *. List.fold_left error_sum 0.0 dataset in
        let theta1_derivative = learning_rate *. prefix_average_factor *. List.fold_left theta1_derivative_sum 0.0 dataset in
        (* Printf.printf "t0_df = %.15f\nt1_df = %.15f\n" theta0_derivative theta1_derivative ;
         * Printf.printf "t0 = %.15f, t1 = %.15f\n" theta0 theta1 ; *)

        let new_theta0 = theta0 +. theta0_derivative in
        let new_theta1 = theta1 -. theta1_derivative in
        aux new_theta0 new_theta1 (current_size + 1)
      end
  in
  aux 0.0 0.0 0
