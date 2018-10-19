(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   dataset.ml                                         :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: sclolus <marvin@42.fr>                     +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2018/10/17 06:21:34 by sclolus           #+#    #+#             *)
(*   Updated: 2018/10/17 06:49:45 by sclolus          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

type entry = (float * float)
type dataset = entry list

let print_dataset dataset =
  let rec aux dataset =
    match dataset with
    | (mileage, price) :: tail -> print_endline ("Mileage: " ^ (string_of_float mileage) ^ " Price: " ^ (string_of_float price)) ;
                                  aux tail
    | [] -> ()
  in
  aux dataset

(* let graph_dataset dataset =
 *   Graphics.open_graph " 1920x1080" ; *)
  
