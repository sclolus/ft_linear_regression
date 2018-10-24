(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   graph.ml                                           :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: sclolus <marvin@42.fr>                     +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2018/10/25 00:18:12 by sclolus           #+#    #+#             *)
(*   Updated: 2018/10/25 00:34:07 by sclolus          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let point_size = 4
let draw_dataset dataset =
  let features = List.sort (fun a b -> compare a b) (List.map (fun (feature, _) -> feature) dataset) in
  let results = List.sort (fun a b -> compare a b) (List.map (fun (_, result) -> result) dataset) in
  if List.length dataset <> 0
  then let min_x = List.hd results in
       let min_y = List.hd features in
       let max_x = List.nth results (List.length results - 1) in
       let max_y = List.nth features (List.length features - 1) in
       let win_width = Graphics.size_x () in
       let win_height = Graphics.size_y () in
       let x_per_pixel = (max_x -. min_x) /. (float_of_int win_width) in
       let y_per_pixel = (max_y -. min_y) /. (float_of_int win_height) in
       let draw_point x y =
         Graphics.draw_circle (int_of_float x) (int_of_float y) (point_size)
       in
       let rec draw_point_list point_list =
         match point_list with
         | (x, y) :: tl -> let x = ((x -. min_x) *. x_per_pixel) in
                           let y = ((y -. min_y) *. y_per_pixel) in
                           assert (x >= (float_of_int win_width) && x < (float_of_int win_width));
                           assert (y >= (float_of_int win_height) && y < (float_of_int win_height));
            draw_point (x *. x_per_pixel) y ;
                           draw_point_list tl
         | [] -> ()
       in
       draw_point_list dataset
       
       
       
                             
